import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/coupon/all_coupons/table/coupon_table_source.dart';

import '../../../../controllers/coupons/coupon_controller.dart';

class CouponDataTable extends StatelessWidget {
  const CouponDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CouponController());
    return Obx(
      () {
        Text(controller.filteredItems.length.toString()); // Redraw th design when the filtered items changes
        Text(controller.selectedRows.length.toString()); // Redraw the design when the selected rows changes
        return TPaginatedDataTable(columns: [
          DataColumn(label: Text('Code')),
          DataColumn(label: Text('Discount Type')),
          DataColumn(label: Text('Discount Value')),
          DataColumn(label: Text('Expiry Date')),
          DataColumn(label: Text('Is Active')),
          DataColumn(label: Text('Actions')),
        ], source: CouponTableSource());
      },
    );
  }
}
