import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/all_products/table/products_table_source.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

class ProductsDataTable extends StatelessWidget {
  const ProductsDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 1000,
      columns: [
      DataColumn2(label: Text('Products'),fixedWidth: !TDeviceUtils.isDesktopScreen(context)? 300 : 400),
      DataColumn2(label: Text('Stock')),
      DataColumn2(label: Text('Brand')),
      DataColumn2(label: Text('Price')),
      DataColumn2(label: Text('Date')),
      DataColumn2(label: Text('Action'),fixedWidth: 100),
    ], source: ProductsRows(),);
  }
}
