import 'package:flutter/material.dart';
import 'package:kamca_app/Controller/ProductCardAnime_controller.dart';
import 'package:kamca_app/Model/Product_Model.dart';

class ProductCarouselSection extends StatelessWidget {
	const ProductCarouselSection({
		super.key,
		required this.controller,
		this.cardWidth = 140,
		this.cardHeight = 176,
	});

	final ProductCardAnimeController controller;
	final double cardWidth;
	final double cardHeight;

	@override
	Widget build(BuildContext context) {
		return AnimatedBuilder(
			animation: controller,
			builder: (context, _) {
				if (controller.isLoading) {
					return const Center(
						child: SizedBox(
							height: 24,
							width: 24,
							child: CircularProgressIndicator(strokeWidth: 2.6),
						),
					);
				}

				if (controller.errorMessage != null && controller.products.isEmpty) {
					return Center(
						child: Column(
							mainAxisSize: MainAxisSize.min,
							children: [
								Text(
									controller.errorMessage!,
									style: const TextStyle(color: Colors.white),
								),
								const SizedBox(height: 8),
								OutlinedButton(
									onPressed: controller.retry,
									style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
									child: const Text('Retry'),
								),
							],
						),
					);
				}

				return LayoutBuilder(
					builder: (context, constraints) {
						final safeCardHeight =
								cardHeight > constraints.maxHeight ? constraints.maxHeight : cardHeight;
						final maxAllowedWidth = constraints.maxWidth * 0.9;
						final safeCardWidth =
								cardWidth > maxAllowedWidth ? maxAllowedWidth : cardWidth;

						return PageView.builder(
							controller: controller.pageController,
							scrollDirection: Axis.horizontal,
							padEnds: false,
							itemBuilder: (context, index) {
								final product = controller.productAt(index);

								return Center(
									child: SizedBox(
										width: safeCardWidth,
										height: safeCardHeight,
										child: ProductCard(
											product: product,
											imageAssetPath: 'assets/WardahFaceWash.png',
										),
									),
								);
							},
						);
					},
				);
			},
		);
	}
}

class ProductCard extends StatelessWidget {
	const ProductCard({
		super.key,
		required this.product,
		required this.imageAssetPath,
	});

	final ProductModel product;
	final String imageAssetPath;

	@override
	Widget build(BuildContext context) {
		return LayoutBuilder(
			builder: (context, constraints) {
				final scale = (constraints.maxWidth / 120).clamp(0.52, 1.0);
				final radius = (constraints.maxWidth * 0.2).clamp(10.0, 18.0);

				final horizontalPadding = (8 * scale).clamp(4.0, 8.0);
				final topPadding = (6 * scale).clamp(3.0, 6.0);
				final bottomPadding = (7 * scale).clamp(3.0, 7.0);
				final spacing = (3 * scale).clamp(1.5, 3.0);
				final rowGap = (1.5 * scale).clamp(0.6, 1.5);

				final priceTypeFont = (10 * scale).clamp(7.0, 10.0);
				final priceFont = (11 * scale).clamp(7.6, 11.0);
				final nameFont = (10.5 * scale).clamp(7.4, 10.5);

				return Container(
					decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(radius),
						color: Colors.white,
						border: Border.all(
							color: Colors.white.withOpacity(0.55),
							width: 1,
						),
					),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								flex: 7,
								child: ClipRRect(
									borderRadius: BorderRadius.only(
										topLeft: Radius.circular(radius),
										topRight: Radius.circular(radius),
									),
									child: Image.asset(
										imageAssetPath,
										width: double.infinity,
										fit: BoxFit.cover,
										gaplessPlayback: true,
									),
								),
							),
							Expanded(
								flex: 3,
								child: Padding(
									padding: EdgeInsets.fromLTRB(
										horizontalPadding,
										topPadding,
										horizontalPadding,
										bottomPadding,
									),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											Row(
												children: [
													Text(
														product.priceType,
														style: TextStyle(
															color: const Color.fromARGB(255, 35, 38, 48),
															fontSize: priceTypeFont,
															fontWeight: FontWeight.w700,
														),
													),
													SizedBox(width: spacing),
													Expanded(
														child: Text(
															product.formattedPrice,
															maxLines: 1,
															overflow: TextOverflow.ellipsis,
															softWrap: false,
															style: TextStyle(
																color: const Color.fromARGB(255, 35, 38, 48),
																fontSize: priceFont,
																fontWeight: FontWeight.w800,
															),
														),
													),
												],
											),
											SizedBox(height: rowGap),
											Flexible(
												child: Text(
													product.product,
													maxLines: 1,
													overflow: TextOverflow.ellipsis,
													softWrap: false,
													style: TextStyle(
														color: const Color.fromARGB(255, 25, 29, 39),
														fontSize: nameFont,
														fontWeight: FontWeight.w600,
														height: 1.15,
													),
												),
											),
										],
									),
								),
							),
						],
					),
				);
			},
		);
	}
}
