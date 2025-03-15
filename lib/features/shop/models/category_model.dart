import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/utils/formatters/formatter.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    required this.name,
    required this.image,
    required this.id,
    this.parentId = '',
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  static CategoryModel empty()=> CategoryModel(id: '', name: '', image: '',isFeatured: false);

  ///Convert CategoryModel to json to send to firebase
  toJson() {
    return {
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': updatedAt = DateTime.now(),
    };
  }

  ///Map json oriented document snapshot data to CategoryModel

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null){
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        parentId: data['parentId'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        createdAt: data.containsKey('createdAt')? data['createdAt']?.toDate() : null,
        updatedAt: data.containsKey('updatedAt')? data['updatedAt']?.toDate() : null,
      );
    }else{
      return CategoryModel.empty();
    }
  }
}
