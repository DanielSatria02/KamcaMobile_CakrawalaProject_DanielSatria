import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kamca_app/Model/Product_Model.dart';

enum ProductCarouselDirection {
	left,
	right,
}

class ProductCardAnimeController extends ChangeNotifier {
	ProductCardAnimeController({
		http.Client? client,
		ProductCarouselDirection? direction,
		double viewportFraction = 0.64,
	})
			: _httpClient = client ?? http.Client(),
				_ownsClient = client == null,
				_direction = direction,
				pageController = PageController(
					viewportFraction: viewportFraction,
					initialPage: _initialPage,
				);

	static const String _productsEndpoint =
			'https://6a3be06ce4a07f202e161a85.mockapi.io/Products';
	static const int _initialPage = 1000;

	final http.Client _httpClient;
	final bool _ownsClient;
	final PageController pageController;
	final ProductCarouselDirection? _direction;
	ProductCarouselDirection get direction =>
			_direction ?? ProductCarouselDirection.right;

	final List<ProductModel> _products = [];
	Timer? _autoSlideTimer;

	bool _isLoading = true;
	String? _errorMessage;
	int _currentPage = _initialPage;

	List<ProductModel> get products => List.unmodifiable(_products);
	bool get isLoading => _isLoading;
	String? get errorMessage => _errorMessage;

	Future<void> initialize() async {
		await fetchProducts();
		WidgetsBinding.instance.addPostFrameCallback((_) {
			_startAutoSlide();
		});
	}

// that's so Raven future vision tells me I will be asked about what this void function is for
	Future<void> fetchProducts() async {
		_isLoading = true;
		_errorMessage = null;
		notifyListeners();

		try {
			final response = await _httpClient.get(Uri.parse(_productsEndpoint));

			if (response.statusCode != 200) {
				throw Exception('Request failed with status ${response.statusCode}');
			}

			final dynamic decoded = jsonDecode(response.body);
			if (decoded is! List) {
				throw Exception('Invalid response format.');
			}

			_products
				..clear()
				..addAll(
					decoded
							.whereType<Map<String, dynamic>>()
							.map(ProductModel.fromJson)
							.toList(),
				);

			if (_products.isEmpty) {
				_errorMessage = 'No products found.';
			}
		} catch (_) {
			_errorMessage = 'Could not load products right now.';
		} finally {
			_isLoading = false;
			notifyListeners();
		}
	}

	ProductModel productAt(int index) {
		if (_products.isEmpty) {
			throw StateError('No products available.');
		}
		return _products[index % _products.length];
	}

	Future<void> retry() async {
		await fetchProducts();
		_startAutoSlide();
	}

	void _startAutoSlide() {
		_autoSlideTimer?.cancel();

		if (_products.isEmpty) {
			return;
		}

		_autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (_) {
			_animateNext();
		});
	}

	Future<void> _animateNext() async {
		if (!pageController.hasClients || _products.isEmpty) {
			return;
		}

		_currentPage +=
				direction == ProductCarouselDirection.left ? 1 : -1;

		try {
			await pageController.animateToPage(
				_currentPage,
				duration: const Duration(milliseconds: 650),
				curve: Curves.easeInOutCubic,
			);
		} catch (_) {
			return;
		}

		if (_currentPage > 2000000 || _currentPage < 10) {
			final wrappedIndex =
					((_currentPage % _products.length) + _products.length) % _products.length;
			_currentPage = _initialPage + wrappedIndex;
			if (pageController.hasClients) {
				pageController.jumpToPage(_currentPage);
			}
		}
	}

	@override
	void dispose() {
		_autoSlideTimer?.cancel();
		pageController.dispose();
		if (_ownsClient) {
			_httpClient.close();
		}
		super.dispose();
	}
}
