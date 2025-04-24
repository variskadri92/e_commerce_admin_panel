import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.fullNameController.text = controller.user.value.fullName;
    controller.phoneController.text = controller.user.value.phoneNumber;
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
                key: controller.userFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        //First Name
                        Expanded(
                          child: TextFormField(
                            controller: controller.fullNameController,
                            decoration: InputDecoration(
                                hintText: 'First Name',
                                label: Text('First Name'),
                                prefixIcon: Icon(Iconsax.user)),
                            validator: (value) => TValidator.validateEmptyText(
                                'First Name', value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
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
                            initialValue:
                                UserController.instance.user.value.email,
                          ),
                        ),
                        SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),

                        //Phone Number
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
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
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              SizedBox(
                  width: double.infinity,
                  child: Obx(() => controller.loading.value
                      ? CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                      : ElevatedButton(
                          onPressed: () => controller.loading.value
                              ? () {}
                              : controller.updateUserInformation(),
                          child: Text('Update Profile'))))
            ],
          ),
        )
      ],
    );
  }
}
