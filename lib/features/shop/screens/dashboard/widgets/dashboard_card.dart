import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/icons/t_circular_icon.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = TColors.success,
    required this.stats,
    this.onTap,
    required this.context,
    required this.headingIcon,
    required this.headingIconColor,
    required this.headingIconBgColor,
  });

  final BuildContext context;
  final String title, subtitle;
  final IconData icon, headingIcon;
  final Color color, headingIconColor, headingIconBgColor;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(TSizes.lg),
      child: Column(
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: headingIcon,
                backgroundColor: headingIconBgColor,
                color: headingIconColor,
                size: TSizes.md,
              ),
              SizedBox(width: TSizes.spaceBtwItems,),
              TSectionHeading(
                title: title,
                textColor: TColors.textSecondary,
              ),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwSections),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              ///Right Side Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ///Indicator
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: color,
                          size: TSizes.iconSm,
                        ),
                        Text(
                          '$stats%',
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                              color: color, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      'Compared to Feb 2025',
                      style: Theme.of(context).textTheme.labelMedium!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
