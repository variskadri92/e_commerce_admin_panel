import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //First and Last name
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        //First Name
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'First Name',
                                label: Text('First Name'),
                                prefixIcon: Icon(Iconsax.user)),
                            validator: (value) => TValidator.validateEmptyText(
                                'First Name', value),
                          ),
                        ),
                        SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),

                        //Last Name
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Last Name',
                                label: Text('Last Name'),
                                prefixIcon: Icon(Iconsax.user)),
                            validator: (value) => TValidator.validateEmptyText(
                                'Last Name', value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwInputFields,),

                    Row(
                      children: [
                        //Email
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Email',
                                label: Text('Email'),
                                prefixIcon: Icon(Iconsax.forward)),
                            enabled: false,
                            validator: (value) => TValidator.validateEmptyText(
                                'Phone Number', value),
                          ),
                        ),
                        SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),

                        //Phone Number
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Phone Number',
                                label: Text('Phone Number'),
                                prefixIcon: Icon(Iconsax.mobile)),
                            validator: (value) => TValidator.validateEmptyText(
                                'Phone Number', value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections,),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: Text('Update Profile'))
              )
            ],
          ),
        )
      ],
    );
  }
}
