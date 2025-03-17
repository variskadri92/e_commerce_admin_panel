import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  String id;
  String productId;
  String categoryId;

  ProductCategoryModel({
    required this.id,
    required this.productId,
    required this.categoryId,
});


  toJson() {
    return {
      'id': id,
      'productId': productId,
      'categoryId': categoryId,
    };
  }

  factory  ProductCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {

    final data = doc.data()!;
    return ProductCategoryModel(
      id: doc.id,
      productId: data['productId'],
      categoryId: data['categoryId'],
    );
  }
}