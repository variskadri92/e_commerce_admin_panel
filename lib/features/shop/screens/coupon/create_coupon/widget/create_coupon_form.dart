import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import '../../../../controllers/coupons/create_coupon_controller.dart';

class CreateCouponForm extends StatelessWidget {
  const CreateCouponForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateCouponController());

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.createCouponFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            const SizedBox(height: TSizes.sm),
            Text('Create New Coupon', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Coupon Code
            TextFormField(
              controller: controller.code,
              decoration: const InputDecoration(labelText: 'Coupon Code'),
              validator: (value) => value!.isEmpty ? 'Enter coupon code' : null,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Discount Type Dropdown
            Obx(() => DropdownButtonFormField<DiscountType>(
              decoration: const InputDecoration(labelText: 'Discount Type'),
              value: controller.selectedDiscountType.value,
              items: DiscountType.values.map((type) {
                return DropdownMenuItem<DiscountType>(
                  value: type,
                  child: Text(type == DiscountType.percentage ? 'Percentage' : 'Amount'),
                );
              }).toList(),
              onChanged: (value) => controller.selectedDiscountType.value = value!,
            )),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Discount Value
            TextFormField(
              controller: controller.discountValue,
              decoration: const InputDecoration(labelText: 'Discount Value'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter discount value' : null,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Minimum Order Value
            TextFormField(
              controller: controller.minimumOrderValue,
              decoration: const InputDecoration(labelText: 'Minimum Order Value'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter minimum order value' : null,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Expiry Date Picker
            Obx(() => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                controller.selectedExpiryDate.value != null
                    ? 'Expiry Date: ${controller.selectedExpiryDate.value!.toLocal().toString().split(' ')[0]}'
                    : 'Select Expiry Date',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  controller.selectedExpiryDate.value = picked;
                }
              },
            )),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Active Checkbox
            Text('Activate this coupon?', style: Theme.of(context).textTheme.bodyMedium),
            Obx(() => CheckboxMenuButton(
              value: controller.isActive.value,
              onChanged: (value) => controller.isActive.value = value ?? false,
              child: const Text('Active'),
            )),
            const SizedBox(height: TSizes.spaceBtwSections * 1.5),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.createCoupon(),
                child: const Text('Create Coupon'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
