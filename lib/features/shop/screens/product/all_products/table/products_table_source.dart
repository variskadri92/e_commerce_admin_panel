import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductsRows extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(Routes.editProducts, arguments: product),
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
                  image: product.thumbnail,
                  imageType: ImageType.network,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Flexible(
                    child: Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                ))
              ],
            ),
          ),
          DataCell(Text(controller.getProductStockTotal(product))),
          DataCell(Text(controller.getProductSoldQuantity(product))),

          //Brand
          DataCell(
            Row(
              children: [
                TRoundedImage(
                  width: 35,
                  height: 35,
                  padding: TSizes.xs,
                  image: product.brand != null
                      ? product.brand!.image
                      : TImages.defaultImage,
                  imageType: product.brand != null
                      ? ImageType.network
                      : ImageType.asset,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Flexible(
                    child: Text(
                  product.brand != null ? product.brand!.name : '',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                ))
              ],
            ),
          ),
          DataCell(Text('₹${controller.getProductPrice(product)}')),
          DataCell(Text(product.formattedDate)),
          DataCell(TTableActionButtons(
            onEditPressed: () {
              Get.toNamed(Routes.editProducts, arguments: product);
            },
            onDeletePressed: () => controller.confirmAndDeleteItem(product),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((e) => e).length;
}
