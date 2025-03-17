import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/all_products/table/products_table_source.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

class ProductsDataTable extends StatelessWidget {
  const ProductsDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(() {
      Visibility(
        visible: false,
        child: Text(controller.filteredItems.length.toString()),
      ); // Redraw th design when the filtered items changes
      Visibility(
        visible: false,
        child: Text(controller.selectedRows.length.toString()),
      ); // Redraw the design when the selected rows changes

      return TPaginatedDataTable(
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        minWidth: 1000,
        columns: [
          DataColumn2(
            label: Text('Product'),
            fixedWidth: !TDeviceUtils.isDesktopScreen(context) ? 300 : 400,
            onSort: (columnIndex, ascending) =>
                controller.sortByName(columnIndex, ascending),
          ),
          DataColumn2(label: Text('Stock'),onSort: (columnIndex, ascending) => controller.sortByStock(columnIndex, ascending),),
          DataColumn2(label: Text('Sold'),onSort: (columnIndex, ascending) => controller.sortBySoldItems(columnIndex, ascending),),
          DataColumn2(label: Text('Brand')),
          DataColumn2(label: Text('Price'),onSort: (columnIndex, ascending) => controller.sortByPrice(columnIndex, ascending),),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: ProductsRows(),
      );
    });
  }
}
