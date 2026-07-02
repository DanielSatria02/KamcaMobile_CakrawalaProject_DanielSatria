class ProductModel {
  const ProductModel({
    required this.id,
    required this.product,
    required this.priceType,
    required this.price,
  });

  final String id;
  final String product;
  final String priceType;
  final double price;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      product: json['product']?.toString() ?? 'Unknown Product',
      priceType: json['priceType']?.toString() ?? 'Rp.',
      price: _parsePrice(json['price']),
    );
  }

  String get formattedPrice {
    if (price % 1 == 0) {
      return price.toStringAsFixed(0);
    }
    return price.toStringAsFixed(2);
  }

  static double _parsePrice(dynamic rawValue) {
    if (rawValue is num) {
      return rawValue.toDouble();
    }

    final normalized = rawValue
            ?.toString()
            .replaceAll(RegExp(r'[^0-9]'), '')
            .trim() ??
        '';

    if (normalized.isEmpty) {
      return 0;
    }

    return double.tryParse(normalized) ?? 0;
  }
}