import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/table/category_table_source.dart';

import '../../../../controllers/category/category_controller.dart';

class CategoryDataTable extends StatelessWidget {
  const CategoryDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      Text(controller.filteredItems.length.toString()); // Redraw th design when the filtered items changes
      Text(controller.selectedRows.length.toString()); // Redraw the design when the selected rows changes

      return TPaginatedDataTable(
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        minWidth: 700,
        columns: [
          DataColumn2(
              label: Text('Category'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending)),
          DataColumn2(
              label: Text('Parent Category')),
          DataColumn2(label: Text('Featured')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CategoryRows(),
      );
    });
  }
}
