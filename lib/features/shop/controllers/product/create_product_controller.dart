import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/products/product_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  GlobalKey<FormState> stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  GlobalKey<FormState> titleDescriptionFormKey = GlobalKey<FormState>();
  final imagesController = ProductImagesController.instance;


  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Observable for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  //Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  ///Create new product
  Future<void> createProduct() async {
    try {
      //Start Loader
      showProgressDialog();

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Check Form Validation
      if (!titleDescriptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Validate stock and pricing form if product type is single
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Ensure a brand is selected
      if (selectedBrand.value == null) {
        throw 'Select Brand for this product';
      }

      //Check variation data if product type is variable
      if (productType.value == ProductType.variable &&
          ProductVariationsController.instance.productVariations.isEmpty) {
        throw 'Add at least one variation or change product type to single';
      }

      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationsController
            .instance.productVariations
            .any((element) =>
                element.price.isNaN ||
                element.stock.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock < 0 ||
                element.image.value.isEmpty);
        if (variationCheckFailed) {
          throw 'Variation data is invalid. Check variation data';
        }
      }

      //Upload product Thumbnail Image
      thumbnailUploader.value = true;
      if (imagesController.selectedThumbnailImageUrl.value == null) {
        throw 'Select Thumbnail Image';
      }

      //Additional Product Images
      additionalImagesUploader.value = true;

      //Product Variation Images
      final variations = ProductVariationsController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        //If admin added variations and then changed the product type, remove all variations
        ProductVariationsController.instance.resetAllValues();
        variations.value = [];
      }

      //Map Product Data to Product Model
      final newProduct = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0.0,
        images: imagesController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0.0,
        thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
        productVisibility: productVisibility.value.toString(),

      );

      productDataUploader.value = true;
      newProduct.id =
          await ProductRepository.instance.createProduct(newProduct);

      //Register product categories if any
      if (selectedCategories.isNotEmpty) {
        if (newProduct.id.isEmpty) {
          throw 'Error Storing Data. Try Again';
        }

        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          final productCategory = ProductCategoryModel(
              productId: newProduct.id, categoryId: category.id);
          await ProductRepository.instance
              .createProductCategory(productCategory);
        }
      }else{
        throw 'Select at least one category';
      }

      ProductController.instance.addItemToLists(newProduct);

      //Remove Loader
      TFullScreenLoader.stopLoading();
      showSuccessDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }

  void resetValues(){
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    titleDescriptionFormKey = GlobalKey<FormState>();
    stockPriceFormKey = GlobalKey<FormState>();
    title.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    description.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    ProductImagesController.instance.additionalProductImagesUrls.clear();
    ProductImagesController.instance.selectedThumbnailImageUrl.value = '';
    // ProductVariationsController.instance.resetAllValues();
    // ProductAttributesController.instance.resetProductAttributes();

    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text('Creating Product'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  TImages.creatingProductIllustration,
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                buildCheckbox('Thumbnail Image', thumbnailUploader),
                buildCheckbox('Additional Images', additionalImagesUploader),
                buildCheckbox('Product Data, Attributes & Variations',
                    productDataUploader),
                buildCheckbox(
                    'Product Categories', categoriesRelationshipUploader),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text('Sit Tight, Your product is uploading...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: Duration(seconds: 2),
          child: value.value
              ? Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: Colors.blue,
                )
              : Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text(label),
      ],
    );
  }

  void showSuccessDialog() {
    Get.dialog(AlertDialog(
      title: Text('Congratulations'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              Get.back();
              resetValues();


            },
            child: Text('Go to Products'))
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            TImages.productsIllustration,
            height: 200,
            width: 200,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text('Congratulations!'),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text('New Product Created Successfully'),
        ],
      ),
    ));
  }
}
