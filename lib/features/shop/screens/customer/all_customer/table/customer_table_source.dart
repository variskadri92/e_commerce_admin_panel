import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;

  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
        onTap: () => Get.toNamed(Routes.customerDetail,
            arguments: customer, parameters: {'customerId': customer.id ?? ''}),
        selected: controller.selectedRows[index],
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(
            Row(
              children: [
                TRoundedImage(
                  width: 50,
                  height: 50,
                  padding: TSizes.xs,
                  image: customer.profilePicture,
                  imageType: ImageType.network,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                    child: Text(
                  customer.fullName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                ))
              ],
            ),
          ),
          DataCell(Text(customer.email)),
          DataCell(Text(customer.phoneNumber)),
          DataCell(
              Text(customer.createdAt == null ? '' : customer.formattedDate)),
          DataCell(
            TTableActionButtons(
              view: true,
              edit: false,
              onViewPressed: () => Get.toNamed(
                Routes.customerDetail,
                arguments: customer,
                parameters: {'customerId': customer.id ?? ''},
              ),
              onDeletePressed: () => controller.confirmAndDeleteItem(customer),
            ),
          )
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((element) => element).length;
}
