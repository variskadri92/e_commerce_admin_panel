import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/coupons/edit_coupon_controller.dart';
import '../../../../models/coupon_model.dart';

class EditCouponForm extends StatelessWidget {
  const EditCouponForm({super.key, required this.coupon});

  final CouponModel coupon;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCouponController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editController.initData(coupon);
    });
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: editController.editCouponFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            const SizedBox(height: TSizes.sm),
            Text('Update Coupon', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Coupon Code
            TextFormField(
              controller: editController.code,
              decoration: const InputDecoration(labelText: 'Coupon Code'),
              validator: (value) => value!.isEmpty ? 'Enter coupon code' : null,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Discount Type Dropdown
            Obx(() => DropdownButtonFormField<DiscountType>(
              decoration: const InputDecoration(labelText: 'Discount Type'),
              value: editController.selectedDiscountType.value,
              items: DiscountType.values.map((type) {
                return DropdownMenuItem<DiscountType>(
                  value: type,
                  child: Text(type == DiscountType.percentage ? 'Percentage' : 'Amount'),
                );
              }).toList(),
              onChanged: (value) => editController.selectedDiscountType.value = value!,
            )),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Discount Value
            TextFormField(
              controller: editController.discountValue,
              decoration: const InputDecoration(labelText: 'Discount Value'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter discount value' : null,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Minimum Order Value
            TextFormField(
              controller: editController.minimumOrderValue,
              decoration: const InputDecoration(labelText: 'Minimum Order Value'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter minimum order value' : null,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Expiry Date Picker
            Obx(() => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                editController.selectedExpiryDate.value != null
                    ? 'Expiry Date: ${editController.selectedExpiryDate.value!.toLocal().toString().split(' ')[0]}'
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
                  editController.selectedExpiryDate.value = picked;
                }
              },
            )),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Active Checkbox
            Text('Activate this coupon?', style: Theme.of(context).textTheme.bodyMedium),
            Obx(() => CheckboxMenuButton(
              value: editController.isActive.value,
              onChanged: (value) => editController.isActive.value = value ?? false,
              child: const Text('Active'),
            )),
            const SizedBox(height: TSizes.spaceBtwSections * 1.5),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => editController.updateCoupon(coupon),
                child: const Text('Update Coupon'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
