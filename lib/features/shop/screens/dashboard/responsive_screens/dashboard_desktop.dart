import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: controller.searchTextController,
                onChanged: (query) => controller.searchQuery(query),
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Iconsax.search_normal),
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Obx(
                () {
                  //Orders & selected rows are hidden =>> Just to update the ui
                  Visibility(visible: false, child: Text(controller.filteredDataList.length.toString()),);

                  return TPaginatedDataTable(

                      sortAscending: controller.sortAscending.value,
                      sortColumnIndex: controller.sortColumnIndex.value,
                      columns: [
                        DataColumn2(label: Text('Column1')),
                        DataColumn2(
                            label: Text('Column2'),
                            onSort: (columnIndex, ascending) =>
                                controller.sortById(columnIndex, ascending)),
                        DataColumn2(label: Text('Column3')),
                        DataColumn2(
                            label: Text('Column4'),
                            onSort: (columnIndex, ascending) =>
                                controller.sortById(columnIndex, ascending)),
                      ],
                      source: MyData());}
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final controller = Get.put(DashboardController());

  @override
  DataRow? getRow(int index) {
    final data = controller.filteredDataList[index];
    return DataRow2(
        onTap: () {},
        selected: controller.selectedRows[index],
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
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
  int get rowCount => controller.filteredDataList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class DashboardController extends GetxController {
  var filteredDataList = <Map<String, String>>[].obs;
  var dataList = <Map<String, String>>[].obs;
  RxList<bool> selectedRows = <bool>[].obs; // Track selected rows
  RxInt sortColumnIndex = 1.obs; // Track sorted column index
  RxBool sortAscending = true.obs; // Track sort order
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredDataList.sort((a, b) {
      // if (ascending) {
      //   return filteredDataList[0]['Column1']
      //       .toString()
      //       .toLowerCase()
      //       .compareTo(filteredDataList[0]['Column1'].toString().toLowerCase());
      // } else {
      //   return filteredDataList[0]['Column1']
      //       .toString()
      //       .toLowerCase()
      //       .compareTo(filteredDataList[0]['Column1'].toString().toLowerCase());
      // }

      if (ascending) {
        return a['Column1']!.toLowerCase().compareTo(b['Column1']!.toLowerCase());
      } else {
        return b['Column1']!.toLowerCase().compareTo(a['Column1']!.toLowerCase());
      }

    });
    this.sortColumnIndex.value = sortColumnIndex;
  }

  void searchQuery(String query) {
    filteredDataList.assignAll(dataList
        .where((item) => item['Column1']!.contains(query.toLowerCase())));
  }

  void getData() {
    selectedRows.assignAll(
        List.generate(36, (index) => false)); // Initialize selectedRows

    dataList.addAll(List.generate(
        36,
        (index) => {
              'Column1': 'Row ${index + 1}-1',
              'Column2': 'Row ${index + 1}-2',
              'Column3': 'Row ${index + 1}-3',
              'Column4': 'Row ${index + 1}-4',
            }));

    filteredDataList.addAll(List.generate(
        36,
        (index) => {
              'Column1': 'Row ${index + 1}-1',
              'Column2': 'Row ${index + 1}-2',
              'Column3': 'Row ${index + 1}-3',
              'Column4': 'Row ${index + 1}-4',
            }));
  }
}
