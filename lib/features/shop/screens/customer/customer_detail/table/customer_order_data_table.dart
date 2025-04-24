import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import 'customer_order_table_source.dart';

class CustomerOrderDataTable extends StatelessWidget {
  const CustomerOrderDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return Obx(
      () {
        Text(controller.filteredCustomerOrders.length
            .toString()); // Redraw th design when the filtered items changes
        Text(controller.selectedRows.length
            .toString()); // Redraw the design when the selected rows

        return TPaginatedDataTable(
            minWidth: 550,
            tableHeight: 640,
            dataRowHeight: kMinInteractiveDimension,
            sortColumnIndex: controller.sortColumnIndex.value,
            sortAscending: controller.sortAscending.value,
            columns: [
              DataColumn2(label: Text('Order ID'),onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
              DataColumn2(label: Text('Date')),
              DataColumn2(label: Text('Items')),
              DataColumn2(
                  label: Text('Status'),
                  fixedWidth:
                      TDeviceUtils.isMobileScreen(context) ? 100 : null),
              DataColumn2(label: Text('Amount'), numeric: true),
            ],
            source: CustomerOrdersRows());
      },
    );
  }
}
