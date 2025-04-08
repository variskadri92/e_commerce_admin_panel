import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get all categories from 'categories' collection
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final result =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///Delete a category from the database
  Future<void> deleteCategory(String categoryId) async {
    try {
        final batch = _db.batch();

        final subcategoriesSnapshot = await _db
            .collection('Categories')
            .where('parentId', isEqualTo: categoryId)
            .get();

        for (var doc in subcategoriesSnapshot.docs) {
          batch.delete(doc.reference);
        }

        final parentCategoryRef = _db.collection('Categories').doc(categoryId);
        batch.delete(parentCategoryRef);

        await batch.commit();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///Create a category in the database
  Future<String> createCategory(CategoryModel newCategory) async {
    try {
      final data = await _db.collection('Categories').add(newCategory.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///Update a category in the database
  Future<void> updateCategory(CategoryModel updatedCategory) async {
    try {
      await _db
          .collection('Categories')
          .doc(updatedCategory.id)
          .update(updatedCategory.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }
}
