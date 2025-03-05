import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';

    return Column(
      children: [
        ///Header
        Row(
          children: [
            IconButton(
                onPressed: () => Get.offAllNamed(Routes.login),
                icon: Icon(CupertinoIcons.clear)),
          ],
        ),

        ///Image
        Image(
          image: AssetImage(
            TImages.deliveredEmailIllustration,
          ),
          height: 300,
          width: 300,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        ///Title & Sub title
        Text(
          TTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          email,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.changeYourPasswordSubTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        ///Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.login),
              child: Text(TTexts.done)),
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        SizedBox(
          width: double.infinity,
          child:
              ElevatedButton(onPressed: () {}, child: Text(TTexts.resendEmail)),
        ),
      ],
    );
  }
}
