import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/banner_model.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;


  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            SizedBox(
              height: TSizes.sm,
            ),
            Text(
              'Update Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Image Uploader & Featured Checkbox
            Column(
              children: [
                GestureDetector(
                  child: TRoundedImage(
                    width: 400,
                    height: 200,
                    image: TImages.defaultImage,
                    imageType: ImageType.asset,
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TextButton(onPressed: () {}, child: Text('Select Image')),
              ],
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            Text(
              'Make your Banner Active or InActive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            CheckboxMenuButton(
                value: true, onChanged: (value) {}, child: Text('Active')),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            DropdownButton(
              items: [
                DropdownMenuItem<String>(value: 'home', child: Text('Home')),
                DropdownMenuItem<String>(
                    value: 'search', child: Text('Search')),
              ],
              onChanged: (String? newValue) {},
              value: 'search',
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Update'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
