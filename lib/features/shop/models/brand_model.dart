import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String image;
  bool? isFeatured;
  String name;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.image,
    this.isFeatured,
    required this.name,
    this.productsCount,
  });

  /// Factory for an empty brand model
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// Convert BrandModel to JSON
  toJson() {
    return {
      'Id': id,
      'Image': image,
      'IsFeatured': isFeatured,
      'Name': name,
      'ProductsCount': productsCount,
    };
  }

  /// Create BrandModel from JSON
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      name: data['Name'] ?? '',
      productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
    );
  }

  /// Create BrandModel from Firestore snapshot
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return BrandModel(
        id: document.id,
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        name: data['Name'] ?? '',
        productsCount: data['ProductsCount'] ?? '',
      );
    } else {
      return BrandModel.empty();
    }
  }
}
