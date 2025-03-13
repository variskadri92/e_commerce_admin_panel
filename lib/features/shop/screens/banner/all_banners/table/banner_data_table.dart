import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import 'banner_data_source.dart';

class BannerDataTable extends StatelessWidget {
  const BannerDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 900,
        dataRowHeight: 110,
        columns: [
          DataColumn2(
              label: Text('Banners'),),
          DataColumn2(
            label: Text('Redirect Screen'),),
          DataColumn2(
              label: Text('Active'),),
          DataColumn2(
              label: Text('Action'),
              fixedWidth: 100),
        ],
        source: BannersRow());
  }
}
