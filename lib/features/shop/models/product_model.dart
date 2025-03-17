import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  String? categoryId;
  BrandModel? brand;
  String? description;
  String productType;
  List<String>? images;
  int soldQuantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.brand,
    this.soldQuantity = 0,
    this.description,
    this.images,
    this.sku,
    this.date,
    this.productAttributes,
    this.productVariations,
  });

  List<ProductAttributeModel>? productAttributes;

  List<ProductVariationModel>? productVariations;

  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        stock: 0,
        price: 0,
        thumbnail: '',
        productType: '',
      );

  toJson() {
    return {
      'sku': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'images': images ?? [],
      'thumbnail': thumbnail,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'brandId': brand!.toJson(),
      'description': description,
      'productType': productType,
      'soldQuantity': soldQuantity,
      'date': date,
      'productAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'productVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : []
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['title'],
      price: double.parse((data['price'] ?? 0.0).toString()),
      sku: data['sku'],
      stock: data['stock'] ?? 0,
      soldQuantity:
          data.containsKey('soldQuantity') ? data['soldQuantity'] ?? 0 : 0,
      isFeatured: data['isFeatured'] ?? false,
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      brand: BrandModel.fromJson(data['brand']),
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: (data['productAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromSnapshot(e))
          .toList(),
      productVariations: (data['productVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromSnapshot(e))
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['title'],
      price: double.parse((data['price'] ?? 0.0).toString()),
      sku: data['sku'],
      stock: data['stock'] ?? 0,
      soldQuantity:
          data.containsKey('soldQuantity') ? data['soldQuantity'] ?? 0 : 0,
      isFeatured: data['isFeatured'] ?? false,
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      brand: BrandModel.fromJson(data['brand']),
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: (data['productAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromSnapshot(e))
          .toList(),
      productVariations: (data['productVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromSnapshot(e))
          .toList(),
    );
  }
}
