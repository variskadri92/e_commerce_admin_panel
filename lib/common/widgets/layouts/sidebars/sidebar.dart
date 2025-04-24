import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import 'menu/menu_item.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.grey, width: 1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //logo
              Row(
                children: [
                  Obx(
                    () => TCircularImage(
                      width: 60,
                      height: 60,
                      margin: TSizes.sm,
                      imageType: SettingsController
                              .instance.settings.value.appLogo.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                      image: SettingsController
                              .instance.settings.value.appLogo.isNotEmpty
                          ? SettingsController.instance.settings.value.appLogo
                          : TImages.lightAppLogo,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => Text(
                        SettingsController.instance.settings.value.appName,
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Menu',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: Colors.grey, letterSpacingDelta: 1.2),
                    ),
                    //menu items
                    MenuItems(
                      route: Routes.dashboard,
                      itemName: 'DashBoard',
                      icon: Iconsax.status,
                    ),
                    MenuItems(
                      route: Routes.media,
                      itemName: 'Media',
                      icon: Iconsax.image,
                    ),
                    MenuItems(
                      route: Routes.categories,
                      itemName: 'Categories',
                      icon: Iconsax.category_2,
                    ),
                    MenuItems(
                      route: Routes.brands,
                      itemName: 'Brands',
                      icon: Iconsax.dcube,
                    ),
                    MenuItems(
                      route: Routes.banners,
                      itemName: 'Banners',
                      icon: Iconsax.picture_frame,
                    ),
                    MenuItems(
                      route: Routes.products,
                      itemName: 'Products',
                      icon: Iconsax.shop,
                    ),
                    MenuItems(
                      route: Routes.customers,
                      itemName: 'Customers',
                      icon: Iconsax.profile_2user,
                    ),
                    MenuItems(
                      route: Routes.orders,
                      itemName: 'Orders',
                      icon: Iconsax.box,
                    ),
                    MenuItems(
                      route: Routes.coupons,
                      itemName: 'Coupons',
                      icon: Iconsax.card,
                    ),

                    Text(
                      'OTHER',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: Colors.grey, letterSpacingDelta: 1.2),
                    ),
                    MenuItems(
                      route: Routes.profile,
                      itemName: 'Profile',
                      icon: Iconsax.user,
                    ),
                    MenuItems(
                      route: Routes.settings,
                      itemName: 'Settings',
                      icon: Iconsax.settings,
                    ),

                    MenuItems(
                      route: Routes.login,
                      itemName: 'Logout',
                      icon: Iconsax.logout,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
