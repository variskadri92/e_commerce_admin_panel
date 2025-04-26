import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../controllers/customer/customer_detail_controller.dart';

class CustomerOrdersRows extends DataTableSource {
  final controller = CustomerDetailController.instance;

  @override
  DataRow? getRow(int index) {
    final order = controller.filteredCustomerOrders[index];
    final totalAmount = order.items.fold<double>(
        0, (previousValue, element) => previousValue + element.price);
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(Routes.orderDetail, arguments: order),
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: TColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(
          Text('${order.items.length} Items'),
        ),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: EdgeInsets.symmetric(
                vertical: TSizes.sm, horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status)
                .withOpacity(0.1),
            child: Text(order.status.name.capitalize.toString(),
                style: TextStyle(
                    color: THelperFunctions.getOrderStatusColor(order.status))),
          ),
        ),
        DataCell(Text('₹$totalAmount')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((element) => element).length;
}
