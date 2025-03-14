import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/order/all_orders/table/order_table_source.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utility.dart';

class OrderDataTable extends StatelessWidget {
  const OrderDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
        minWidth: 700,
        columns: [
          DataColumn2(label: Text('Order ID')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Items')),
          DataColumn2(label: Text('Status'),fixedWidth: TDeviceUtils.isMobileScreen(context)? 120 : null),
          DataColumn2(label: Text('Amount'),numeric: true),
          DataColumn2(label: Text('Action'),fixedWidth: 100),
        ], source: OrderRows());
  }
}
