import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/banner/banner_controller.dart';
import 'banner_data_source.dart';

class BannerDataTable extends StatelessWidget {
  const BannerDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      Text(controller.filteredItems.length
          .toString()); // Redraw th design when the filtered items changes
      Text(controller.selectedRows.length
          .toString()); // Redraw the design when the selected rows

      return TPaginatedDataTable(
          sortColumnIndex: controller.sortColumnIndex.value,
          sortAscending: controller.sortAscending.value,
          minWidth: 700,
          tableHeight: 900,
          dataRowHeight: 110,
          columns: [
            DataColumn2(
              label: Text('Banners'),
            ),
            DataColumn2(
              label: Text('Redirect Screen'),
            ),
            DataColumn2(
              label: Text('Active'),
            ),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: BannersRow());
    });
  }
}
