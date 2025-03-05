import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
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
          border: Border(right: BorderSide(color: Colors.grey,width: 1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //logo
              TCircularImage(width: 100,height: 100,image: TImages.lightAppLogo,backgroundColor: Colors.black,),
              SizedBox(height: TSizes.spaceBtwSections,),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Menu',style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.grey),),
                    //menu items
                    MenuItems(route: Routes.firstScreen, itemName: 'DashBoard', icon: Iconsax.status,),
                    MenuItems(route: Routes.secondScreen, itemName: 'Media', icon: Iconsax.status,),
                    MenuItems(route: Routes.responsiveDesignScreen, itemName: 'Product', icon: Iconsax.status,),
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

