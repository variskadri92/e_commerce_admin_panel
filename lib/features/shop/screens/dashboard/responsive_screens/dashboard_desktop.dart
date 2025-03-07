import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../widgets/dashboard_card.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: TSizes.spaceBtwSections),

              //Cards
              Row(
                children: [
                  Expanded(child: DashboardCard(title: 'Sales total',subtitle: '\$120,000',stats: 25,)),
                  SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: DashboardCard(title: 'Average Order Value',subtitle: '\$120',stats: 15,)),
                  SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: DashboardCard(title: 'Total Orders',subtitle: '26',stats: 44,)),
                  SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: DashboardCard(title: 'Visitors',subtitle: '23,456',stats: 25,)),
                ],
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
        return a['Column1']!
            .toLowerCase()
            .compareTo(b['Column1']!.toLowerCase());
      } else {
        return b['Column1']!
            .toLowerCase()
            .compareTo(a['Column1']!.toLowerCase());
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
