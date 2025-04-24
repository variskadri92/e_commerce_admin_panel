import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/coupon_model.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/coupon/coupon_repository.dart';

class CouponController extends BaseDataTableController<CouponModel>{
  static CouponController get instance => Get.find();

  final _couponRepository = Get.put(CouponRepository());
  @override
  bool containsSearchQuery(CouponModel item, String query) {
    return item.code.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(CouponModel item) async{
    await _couponRepository.deleteCoupon(item.code);
  }

  @override
  Future<List<CouponModel>> fetchItems()async{
    return await _couponRepository.getAllCoupons();
  }
}