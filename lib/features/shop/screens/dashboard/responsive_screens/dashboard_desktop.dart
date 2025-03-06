import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: PaginatedDataTable2(
              columnSpacing: 12,
              minWidth: 786,
              dividerThickness: 0,
              horizontalMargin: 12,
              dataRowHeight: 56,
              headingTextStyle: Theme.of(context).textTheme.titleMedium,
              headingRowColor: WidgetStateProperty.resolveWith(
                  (states) => TColors.primaryBackground),
              headingRowDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(TSizes.borderRadiusMd),
                topRight: Radius.circular(TSizes.borderRadiusMd),
              )),
              showCheckboxColumn: true,
              rowsPerPage: 12,
              columns: [
                DataColumn2(label: Text('Column1')),
                DataColumn2(label: Text('Column2')),
                DataColumn2(label: Text('Column3')),
                DataColumn2(label: Text('Column4')),
              ],
              source: MyData()),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource{
  final controller = Get.put(DashboardController());
  @override
  DataRow? getRow(int index) {
    final data = controller.dataList[index];
    return DataRow2(cells: [
      DataCell(Text(data['Column1'] ?? '')),
      DataCell(Text(data['Column2'] ?? '')),
      DataCell(Text(data['Column3'] ?? '')),
      DataCell(Text(data['Column4'] ?? '')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => controller.dataList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}

class DashboardController extends GetxController{
  var dataList = <Map<String, String>>[].obs;

  @override
  void onInit(){
    super.onInit();
    getData();
  }

  void getData(){
    dataList.addAll(List.generate(36, (index) => {
      'Column1': 'Row ${index +1}-1',
      'Column2': 'Row ${index +1}-2',
      'Column3': 'Row ${index +1}-3',
      'Column4': 'Row ${index +1}-4',
    }));
  }
}
