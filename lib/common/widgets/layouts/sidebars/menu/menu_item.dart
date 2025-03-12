import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/link.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    super.key,
    required this.route,
    required this.itemName,
    required this.icon,
  });

  final String route, itemName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SidebarController());
    return InkWell(
      onTap: () => controller.menuOnTap(route),
      onHover: (value) => value
          ? controller.changeHoverItem(route)
          : controller.changeHoverItem(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color: controller.isHovering(route) || controller.isActive(route)
                  ? TColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: TSizes.lg,
                      right: TSizes.md,
                      top: TSizes.md,
                      bottom: TSizes.md),
                  child: controller.isActive(route)
                      ? Icon(
                          icon,
                          color: Colors.white,
                        )
                      : Icon(
                          icon,
                          size: 22,
                          color: controller.isHovering(route)
                              ? TColors.white
                              : TColors.darkerGrey,
                        ),
                ),

                //Text
                if (controller.isHovering(route) || controller.isActive(route))
                  Flexible(
                      child: Text(itemName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: Colors.white)))
                else
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.darkerGrey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Link(
// uri: route != 'logout' ? Uri.parse(route) : null,
// builder: (_,__)=>InkWell(
// onTap: () => controller.menuOnTap(route),
// onHover: (value) => value
// ? controller.changeHoverItem(route)
//     : controller.changeHoverItem(''),
// child: Obx(
// () => Padding(
// padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
// child: Container(
// decoration: BoxDecoration(
// color: controller.isHovering(route) || controller.isActive(route)
// ? TColors.primary
//     : Colors.transparent,
// borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
// ),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Padding(
// padding: const EdgeInsets.only(
// left: TSizes.lg,
// right: TSizes.md,
// top: TSizes.md,
// bottom: TSizes.md),
// child: controller.isActive(route)
// ? Icon(
// icon,
// color: Colors.white,
// )
//     : Icon(
// icon,
// size: 22,
// color: controller.isHovering(route)
// ? TColors.white
//     : TColors.darkerGrey,
// ),
// ),
//
// //Text
// if (controller.isHovering(route) || controller.isActive(route))
// Flexible(
// child: Text(itemName,
// style: Theme.of(context)
//     .textTheme
//     .bodyMedium!
//     .apply(color: Colors.white)))
// else
// Flexible(
// child: Text(
// itemName,
// style: Theme.of(context)
//     .textTheme
//     .bodyMedium!
//     .apply(color: TColors.darkerGrey),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// )



