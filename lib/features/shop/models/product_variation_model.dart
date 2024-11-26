
class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeVales;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeVales,
  });

  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeVales: {});

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'SKU': sku,
      'Stock': stock,
      'AttributeValues': attributeVales,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: document['Id'] ?? '',
      sku: document['SKU'] ?? '',
      image: document['Image'] ?? '',
      description: document['Description'] ?? '',
      price: double.tryParse(document['Price']?.toString() ?? '0.0') ?? 0.0,
      salePrice: double.tryParse(document['SalePrice']?.toString() ?? '0.0') ?? 0.0,
      stock: int.tryParse(document['Stock']?.toString() ?? '0') ?? 0,
      attributeVales: document['AttributeValues'] != null
          ? Map<String, String>.from(document['AttributeValues'])
          : {},
    );
  }
}