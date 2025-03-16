import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/brands/all_brands/table/brand_table_source.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import '../../../../controllers/brand/brand_controller.dart';

class BrandDataTable extends StatelessWidget {
  const BrandDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Obx(
      () {
        Text(controller.filteredItems.length
            .toString()); // Redraw th design when the filtered items changes
        Text(controller.selectedRows.length
            .toString()); // Redraw the design when the selected rows changes

        final lgTable = controller.filteredItems.any((element) =>
            element.brandCategories != null &&
            element.brandCategories!.length > 2);
        return TPaginatedDataTable(
            minWidth: 700,
            dataRowHeight: lgTable ? 96 : 64,
            tableHeight: lgTable ? 96 * 11.5 : 760,
            sortAscending: controller.sortAscending.value,
            sortColumnIndex: controller.sortColumnIndex.value,
            columns: [
              DataColumn2(
                  label: Text('Brand'),
                  onSort: (columnIndex, ascending) =>
                      controller.sortByName(columnIndex, ascending),
                  fixedWidth:
                      TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
              DataColumn2(
                label: Text('Categories'),
              ),
              DataColumn2(
                  label: Text('Featured'),
                  fixedWidth:
                      TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
              DataColumn2(
                  label: Text('Date'),
                  fixedWidth:
                      TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
              DataColumn2(
                  label: Text('Action'),
                  fixedWidth:
                      TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
            ],
            source: BrandRows());
      },
    );
  }
}
