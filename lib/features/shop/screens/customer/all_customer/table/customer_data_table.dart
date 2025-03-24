import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';

import '../../../../controllers/customer/customer_controller.dart';
import 'customer_table_source.dart';

class CustomerDataTable extends StatelessWidget {
  const CustomerDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());

    return Obx(
      () {
        Text(controller.filteredItems.length
            .toString()); // Redraw th design when the filtered items changes
        Text(controller.selectedRows.length
            .toString()); // Redraw the design when the selected rows
        return TPaginatedDataTable(
            minWidth: 700,
            sortColumnIndex: controller.sortColumnIndex.value,
            sortAscending: controller.sortAscending.value,
            columns: [
              DataColumn2(label: Text('Customer'),onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
              DataColumn2(label: Text('Email')),
              DataColumn2(label: Text('Phone Number')),
              DataColumn2(label: Text('Registered')),
              DataColumn2(label: Text('Action'), fixedWidth: 100),
            ],
            source: CustomerRows());
      },
    );
  }
}
