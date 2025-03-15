import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get all categories from 'categories' collection
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final result = snapshot.docs.map((doc)=> CategoryModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Failed to fetch categories';
    }
  }
}
