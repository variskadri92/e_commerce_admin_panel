import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Get all brands from firebase
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///Get all brand category from BrandCategory collection firebase
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final snapshot = await _db.collection('BrandCategory').get();
      final result = snapshot.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///Create a brand in the database
  Future<String> createBrand(BrandModel newBrand) async {
    try {
      final data = await _db.collection('Brands').add(newBrand.toJson());
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

  ///Create a brand in the database
  Future<String> createBrandCategory(
      BrandCategoryModel newBrandCategory) async {
    try {
      final data =
          await _db.collection('BrandCategory').add(newBrandCategory.toJson());
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
  Future<void> updateBrand(BrandModel updatedBrand) async {
    try {
      await _db
          .collection('Brands')
          .doc(updatedBrand.id)
          .update(updatedBrand.toJson());
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

  ///Delete a brand and its associated categories from the database
  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection('Brands').doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception("Brand not found");
        }

        final brandCategoriesSnapshot = await _db
            .collection('BrandCategory')
            .where('brandId', isEqualTo: brand.id)
            .get();
        final brandCategories = brandCategoriesSnapshot.docs
            .map((e) => BrandCategoryModel.fromSnapshot(e));

        if (brandCategories.isNotEmpty) {
          for (var brandCategory in brandCategories) {
            transaction
                .delete(_db.collection('BrandCategory').doc(brandCategory.id));
          }
        }
        transaction.delete(brandRef);
      });
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

  ///Delete a brand and its associated categories from the database
  Future<void> deleteBrandCategory(String brandCategoryId) async {
    try {
      await _db.collection('BrandCategory').doc(brandCategoryId).delete();
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

  ///Get specific brand categories for given brand ID from firebase
  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(
      String brandId) async {
    try {
      final brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('brandId', isEqualTo: brandId)
          .get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
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
