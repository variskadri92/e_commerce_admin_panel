import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/order/all_orders/table/order_table_source.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/order/order_controller.dart';

class OrderDataTable extends StatelessWidget {
  const OrderDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

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
              DataColumn2(label: Text('Order ID')),
              DataColumn2(
                  label: Text('Date'),
                  onSort: (columnIndex, ascending) =>
                      controller.sortByDate(columnIndex, ascending)),
              DataColumn2(label: Text('Items')),
              DataColumn2(
                  label: Text('Status'),
                  fixedWidth:
                      TDeviceUtils.isMobileScreen(context) ? 120 : null),
              DataColumn2(label: Text('Amount'), numeric: true),
              DataColumn2(label: Text('Action'), fixedWidth: 100),
            ],
            source: OrderRows());
      },
    );
  }
}
