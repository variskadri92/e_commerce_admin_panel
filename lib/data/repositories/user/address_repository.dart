import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/address_model.dart';

import '../authentication/authentication_repository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses(String userId) async {
    try {
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((doc) => AddressModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'Selected Address': selected});
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}
