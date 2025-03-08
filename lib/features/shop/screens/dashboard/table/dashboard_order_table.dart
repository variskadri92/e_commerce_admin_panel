import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/dashboard/table/table_source.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
        tableHeight: 500,
        dataRowHeight: TSizes.xl * 1.2,

        columns: [
      DataColumn2(label: Text('Order ID')),
      DataColumn2(label: Text('Date')),
      DataColumn2(label: Text('Items')),
      DataColumn2(label: Text('Status')),
      DataColumn2(label: Text('Amount')),
    ], source: OrderRows());
  }
}
