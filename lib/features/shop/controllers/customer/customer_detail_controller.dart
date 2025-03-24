import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

import '../../../../data/repositories/user/address_repository.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/order_model.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressesLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  ///Load customer orders
  Future<void> getCustomerOrders() async {
    try {
      ordersLoading.value = true;

      //Fetch customer orders and addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders =
            await UserRepository.instance.fetchUserOrders(customer.value.id!);
      }

      //Update the categories list
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      //Filter featured categories
      filteredCustomerOrders.assignAll(customer.value.orders ?? []);

      //Add all rows as false & toggle when required
      selectedRows.assignAll(List.generate(
          customer.value.orders != null ? customer.value.orders!.length : 0,
          (index) => false));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  ///Load customer addresses
  Future<void> getCustomerAddresses() async {
    try {
      addressesLoading.value = true;

      //Fetch customer addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses =
            await addressRepository.fetchUserAddresses(customer.value.id!);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      addressesLoading.value = false;
    }
  }

  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(allCustomerOrders.where((customer) =>
        customer.id.toLowerCase().contains(query.toLowerCase()) ||
        customer.orderDate.toString().contains(query.toLowerCase())));

    update();
  }

  void sortById(int sortColumnIndex, bool ascending){
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a,b){
      if(ascending){
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      }else{
        return b.id.toLowerCase().compareTo(a.id.toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;
    update();
  }
}
