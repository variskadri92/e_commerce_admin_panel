import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/all_category/table/table_source.dart';

class CategoryDataTable extends StatelessWidget {
  const CategoryDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      columns: [
      DataColumn2(label: Text('Category')),
      DataColumn2(label: Text('Parent Category')),
      DataColumn2(label: Text('Featured')),
      DataColumn2(label: Text('Date')),
      DataColumn2(label: Text('Action'),fixedWidth: 100),
    ], source: CategoryRows(),);
  }
}
