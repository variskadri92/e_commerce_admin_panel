import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/coupon_model.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../routes/routes.dart';
import '../../../../controllers/coupons/coupon_controller.dart';

class CouponTableSource extends DataTableSource{
  final controller = CouponController.instance;
  @override
  DataRow? getRow(int index) {
    final coupon = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onSelectChanged: (value)=>controller.selectedRows[index] = value ?? false,
        cells: [
      DataCell(Text(coupon.code)),
      DataCell(Text(CouponModel.discountTypeFormatted(coupon.discountType))),
      DataCell(Text(coupon.discountValue.toString())),
      DataCell(Text(coupon.expiryDate.toString())),
      DataCell(Text(coupon.isActive.toString())),
          DataCell(TTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editCoupons, arguments: coupon),
            onDeletePressed: ()=> controller.confirmAndDeleteItem(coupon),
          )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}