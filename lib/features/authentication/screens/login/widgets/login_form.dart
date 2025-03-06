import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),

            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            ///Password
            Obx(
              ()=> TextFormField(
                controller: controller.password,
                validator: (value) =>
                    TValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(onPressed: ()=>controller.hidePassword.value = !controller.hidePassword.value, icon: controller.hidePassword.value? Icon(Iconsax.eye_slash) :Icon(Iconsax.eye)),
                ),
              ),
            ),

            SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            ///Remember ME & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                          ()=> Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.rememberMe.value = !controller.rememberMe.value;
                        },
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Text(TTexts.rememberMe),
                  ],
                ),

                ///Forget Password
                TextButton(
                    onPressed: () => Get.toNamed(Routes.forgetPassword),
                    child: Text(TTexts.forgetPassword)),
              ],
            ),

            SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///Sign in button
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: ()=> controller.emailAndPasswordSignIn(), child: Text(TTexts.signIn)),
              //child:
                //  ElevatedButton(onPressed: ()=> controller.registerAdmin(), child: Text(TTexts.signIn)),
            )
          ],
        ),
      ),
    );
  }
}
