import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utility.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
   const Header({super.key, this.scaffoldKey});
   ///Scaffold key to access  its state

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(

        //Mobile menu
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(onPressed: () => scaffoldKey?.currentState?.openDrawer(), icon: Icon(Iconsax.menu))
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
              TRoundedImage(
                height: 40,
                width: 40,
                padding: 2,
                imageType: ImageType.asset,
                image: TImages.user,
              ),
              SizedBox(width: TSizes.sm,),
              //NAme and email
              if(TDeviceUtils.isDesktopScreen(context))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Yash',style: Theme.of(context).textTheme.titleLarge,),
                    Text('yashgotrijiya@gmail.com',style: Theme.of(context).textTheme.titleLarge,),
                  ],
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
