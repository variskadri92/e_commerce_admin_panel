import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class CategoryRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(
        Row(
          children: [
            TRoundedImage(
              width: 50,
              height: 50,
              padding: TSizes.sm,
              image: TImages.acerlogo,
              imageType: ImageType.asset,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Expanded(
                child: Text(
              'Name',
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
      DataCell(Text('Parent')),
      DataCell(Icon(Iconsax.heart5, color: Colors.red,)),
      DataCell(Text(DateTime.now().toString())),
      DataCell(
        TTableActionButtons(
          onEditPressed: ()=> Get.toNamed(Routes.editCategories,arguments: 'category'),
          onDeletePressed: (){},
        )
      ),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => 5;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
