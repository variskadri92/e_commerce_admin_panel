import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class BrandRows extends DataTableSource {
  final controller = BrandController.instance;

  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];
    return DataRow2(
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
                  padding: TSizes.sm,
                  image: brand.image,
                  imageType: ImageType.network,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                    child: Text(
                  brand.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                ))
              ],
            ),
          ),
          DataCell(
            Padding(
              padding: EdgeInsets.symmetric(vertical: TSizes.sm),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: TSizes.xs,
                  direction: TDeviceUtils.isMobileScreen(Get.context!)
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: brand.brandCategories != null
                      ? brand.brandCategories!
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      TDeviceUtils.isMobileScreen(Get.context!)
                                          ? 0
                                          : TSizes.xs),
                              child: Chip(
                                label: Text(e.name),
                                padding: EdgeInsets.all(TSizes.xs),
                              ),
                            ),
                          )
                          .toList()
                      : [SizedBox()],
                ),
              ),
            ),
          ),
          DataCell(brand.isFeatured
              ? Icon(
                  Iconsax.heart5,
                  color: Colors.red,
                )
              : Icon(Iconsax.heart)),
          DataCell(Text(brand.createdAt != null ? brand.formattedDate:'')),
          DataCell(TTableActionButtons(
            onEditPressed: () => Get.toNamed(Routes.editBrands, arguments: brand),
            onDeletePressed: ()=> controller.confirmAndDeleteItem(brand),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
