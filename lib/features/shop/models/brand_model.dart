import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';

import '../../../utils/formatters/formatter.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  //Not mapped
  List<CategoryModel>? brandCategories;

  BrandModel({
    required this.name,
    required this.image,
    required this.id,
    this.isFeatured = false,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
    this.brandCategories,
  });

  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'productsCount': productsCount = 0,
      'updatedAt': updatedAt = DateTime.now(),
    };
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return BrandModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        productsCount: data['productsCount'] ?? 0,
        isFeatured: data['isFeatured'] ?? false,
        createdAt: data.containsKey('createdAt')? data['createdAt']?.toDate() : null,
        updatedAt: data.containsKey('updatedAt')? data['updatedAt']?.toDate() : null,
      );
    }else{
      return BrandModel.empty();
    }
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    final data = json;
    if(data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      productsCount: int.parse((data['productsCount'] ?? 0).toString()),
      createdAt: data.containsKey('createdAt')? data['createdAt']?.toDate() : null,
      updatedAt: data.containsKey('updatedAt')? data['updatedAt']?.toDate() : null,
    );
  }
}
