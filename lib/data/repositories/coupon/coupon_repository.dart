import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/coupon_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CouponRepository extends GetxController {
  static CouponRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Get all coupons from 'coupons' collection
  Future<List<CouponModel>> getAllCoupons() async {
    try {
      final snapshot = await _db.collection('Coupons').get();
      final result =
          snapshot.docs.map((doc) => CouponModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///Create a coupon in the database
  Future<void> createCoupon(CouponModel newCoupon) async {
    try {
      await _db
          .collection('Coupons')
          .doc(newCoupon.code)
          .set(newCoupon.toJson());
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

  ///Update a coupon in the database
  Future<void> updateCoupon(String originalCode, CouponModel updatedCoupon) async {
    try {
      final couponCollection = _db.collection('Coupons');

      // If code is changed, delete old doc and create new one
      if (originalCode != updatedCoupon.code) {
        // Get the data from original if needed before deleting (optional)
        await couponCollection.doc(originalCode).delete();
        await couponCollection
            .doc(updatedCoupon.code)
            .set(updatedCoupon.toJson());
      } else {
        // Code didn't change, just update
        await couponCollection
            .doc(updatedCoupon.code)
            .update(updatedCoupon.toJson());
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

  ///Delete a coupon in the database
  Future<void> deleteCoupon(String couponCode) async {
    try {
      await _db.collection('Coupons').doc(couponCode).delete();
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
