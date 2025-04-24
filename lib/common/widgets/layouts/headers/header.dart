import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

import '../../../../features/authentication/controllers/user_controller.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key, this.scaffoldKey});

  ///Scaffold key to access  its state

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(
        //Mobile menu
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: Icon(Iconsax.menu))
            : null,
        title: TDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search anything...'),
                ),
              )
            : null,
        actions: [
          //search icon only on mobile and tablet
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(onPressed: () {}, icon: Icon(Iconsax.search_normal)),
          //notification icon
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.notification),
          ),
          SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),
          //user data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => TRoundedImage(
                  height: 40,
                  width: 40,
                  padding: 2,
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : TImages.user,
                ),
              ),
              SizedBox(
                width: TSizes.sm,
              ),
              //NAme and email
              if (!TDeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.loading.value
                          ? TShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                      controller.loading.value
                          ? TShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.email,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
