import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Create Product
  Future<String> createProduct(ProductModel newProduct) async {
    try {
      final data = await _db.collection('Products').add(newProduct.toJson());
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

  ///Create Product category
  Future<String> createProductCategory(
      ProductCategoryModel newProductCategory) async {
    try {
      final data = await _db
          .collection('ProductCategory')
          .add(newProductCategory.toJson());
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

  ///Update a product in the database
  Future<void> updateProduct(ProductModel updatedProduct) async {
    try {
      await _db
          .collection('Products')
          .doc(updatedProduct.id)
          .update(updatedProduct.toJson());
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

  ///Update a product instance
  Future<void> updateProductSpecificValue(id, Map<String, dynamic> data) async {
    try {
      await _db.collection('Products').doc(id).update(data);
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

  ///Update a product count for corresponding brand
  Future<void> updateProductCountForBrand(String brandId) async {
    try {
      await _db.collection('Brands').doc(brandId).update({
        'productsCount': FieldValue.increment(1),
        'updatedAt': DateTime.now(),
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

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      final result =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<List<ProductCategoryModel>> getProductCategories(
      String productId) async {
    try {
      final snapshot = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: productId)
          .get();
      final result = snapshot.docs
          .map((doc) => ProductCategoryModel.fromSnapshot(doc))
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

  ///Delete a product from the database
  Future<void> deleteProduct(ProductModel product) async {
    try {
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection('Products').doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception('Product does not exist');
        }

        //Fetch product categories
        final productCategoriesSnapshot = await _db
            .collection('ProductCategory')
            .where('productId', isEqualTo: product.id)
            .get();
        final productCategories = productCategoriesSnapshot.docs
            .map((doc) => ProductCategoryModel.fromSnapshot(doc));

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            transaction.delete(
                _db.collection('ProductCategory').doc(productCategory.id));
          }
        }
        if (product.brand != null && product.brand!.id.isNotEmpty) {
          final brandRef = _db.collection('Brands').doc(product.brand!.id);
          transaction.update(brandRef, {
            'productsCount': FieldValue.increment(-1),
            'updatedAt': DateTime.now(),
          });
        }
        transaction.delete(productRef);
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

  ///Delete a product category from the database
  Future<void> deleteProductCategory(
      String productId, String categoryId) async {
    try {
      final result = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: productId)
          .where('categoryId', isEqualTo: categoryId)
          .get();

      for (var doc in result.docs) {
        await doc.reference.delete();
      }
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
