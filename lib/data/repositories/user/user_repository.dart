import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/order_model.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  ///Function to save user data to Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Function to save user data to Firestore
  Future<UserModel> fetchAdminDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();
     return UserModel.fromSnapshot(documentSnapshot);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Function to get all user data from Firestore
  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _db.collection("Users").orderBy('FullName').get();
     return querySnapshot.docs.map((doc)=> UserModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Function to get user detail based on user id from Firestore
  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(id).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///
  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      final documentSnapshot = await _db.collection("Orders").where('userId',isEqualTo: userId).get();
      return documentSnapshot.docs.map((doc)=> OrderModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///update user data

  Future<void> updateUserDetails(UserModel updatedUser)async{
    try{
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    }
    on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  ///update single field of user
  Future<void> updateSingleField(Map<String, dynamic> json)async{
    try{
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    }
    on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// remove user data

  Future<void> deleteUser(String userId)async{
    try{
      await _db.collection("Users").doc(userId).delete();
    }
    on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
}
