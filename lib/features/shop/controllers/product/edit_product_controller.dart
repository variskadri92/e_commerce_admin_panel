import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
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
import '../../models/brand_category_model.dart';
import '../category/category_controller.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final imagesController = Get.put(ProductImagesController());
  final productAttributesController = Get.put(ProductAttributesController());
  final productVariationsController = Get.put(ProductVariationsController());
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Observable for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  // New properties for parent/subcategory structure
  final RxList<CategoryModel> selectedParentCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> selectedSubCategories = <CategoryModel>[].obs;
  List<BrandCategoryModel> fetchedBrandCategories = [];

  // Get all selected categories (parents + subs)
  List<CategoryModel> get allSelectedCategories => [
    ...selectedParentCategories,
    ...selectedSubCategories,
  ];

  //Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  ///Initialize product data
  void initProductData(ProductModel product) {
    try {
      isLoading.value = true;

      //Basic Info
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;

      //Stock and Pricing
      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      //Product Brand
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      //Product Thumbnail and Images
      if (product.images != null) {
        imagesController.selectedThumbnailImageUrl.value = product.thumbnail;
        imagesController.additionalProductImagesUrls.value =
            product.images ?? [];
      }

      if (product.productVisibility == ProductVisibility.published.toString()) {
        productVisibility.value = ProductVisibility.published;
      } else {
        productVisibility.value = ProductVisibility.hidden;
      }

      //Product Attributes and Variations
      productAttributesController.productAttributes
          .assignAll(product.productAttributes ?? []);
      productVariationsController.productVariations
          .assignAll(product.productVariations ?? []);
      productVariationsController
          .initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print('error');
        print(e);
      }
    }
  }

  Future<List<BrandCategoryModel>> brandCategories() async {
    fetchedBrandCategories =
    await BrandRepository.instance.getAllBrandCategories();
    return fetchedBrandCategories;
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;

    final productCategories =
    await productRepository.getProductCategories(productId);
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fetchItems();
    }

    if (fetchedBrandCategories.isEmpty) {
      await brandCategories();
    }

    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final allCategories = categoriesController.allItems
        .where((element) => categoriesIds.contains(element.id))
        .toList();

    // Separate parents and subcategories
    final parents = allCategories.where((cat) => cat.parentId.isEmpty).toList();
    final subs = allCategories.where((cat) => cat.parentId.isNotEmpty).toList();

    selectedParentCategories.assignAll(parents);
    selectedSubCategories.assignAll(subs);
    selectedCategories.assignAll(allCategories);  // Keep this for backward compatibility
    alreadyAddedCategories.assignAll(allCategories);

    selectedCategoriesLoader.value = false;
    return allCategories;
  }

  void updateSelectedBrand(BrandModel? brand) {
    selectedBrand.value = brand;
    selectedParentCategories.clear();
    selectedSubCategories.clear();
  }

  void toggleParentCategory(CategoryModel category) {
    if (selectedParentCategories.contains(category)) {
      selectedParentCategories.remove(category);
      // Remove any subcategories of this parent
      selectedSubCategories.removeWhere((sub) => sub.parentId == category.id);
    } else {
      selectedParentCategories.add(category);
    }

    // Update the main selectedCategories list for backward compatibility
    selectedCategories.clear();
    selectedCategories.addAll(allSelectedCategories);
  }

  void toggleSubCategory(CategoryModel category) {
    if (selectedSubCategories.contains(category)) {
      selectedSubCategories.remove(category);
    } else {
      // Ensure parent is selected
      if (!selectedParentCategories.any((p) => p.id == category.parentId)) {
        final parent = CategoryController.instance.allItems
            .firstWhere((p) => p.id == category.parentId);
        selectedParentCategories.add(parent);
      }
      selectedSubCategories.add(category);
    }

    // Update the main selectedCategories list for backward compatibility
    selectedCategories.clear();
    selectedCategories.addAll(allSelectedCategories);
  }

  void removeParentCategory(CategoryModel category) {
    selectedParentCategories.remove(category);
    // Remove any subcategories of this parent
    selectedSubCategories.removeWhere((sub) => sub.parentId == category.id);

    // Update the main selectedCategories list for backward compatibility
    selectedCategories.clear();
    selectedCategories.addAll(allSelectedCategories);
  }

  void removeSubCategory(CategoryModel category) {
    selectedSubCategories.remove(category);

    // Update the main selectedCategories list for backward compatibility
    selectedCategories.clear();
    selectedCategories.addAll(allSelectedCategories);
  }

  ///Update product
  Future<void> updateProduct(ProductModel updatedProduct) async {
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
      final imagesController = ProductImagesController.instance;
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

      updatedProduct.sku = '';
      updatedProduct.isFeatured = true;
      updatedProduct.title = title.text.trim();
      updatedProduct.brand = selectedBrand.value;
      updatedProduct.description = description.text.trim();
      updatedProduct.productType = productType.value.toString();
      updatedProduct.stock = int.tryParse(stock.text.trim()) ?? ProductVariationsController.instance.productVariations
          .fold(0, (sum, variation) => sum + variation.stock);
      updatedProduct.price = double.tryParse(price.text.trim()) ?? 0.0;
      updatedProduct.salePrice = double.tryParse(salePrice.text.trim()) ?? 0.0;
      updatedProduct.images = imagesController.additionalProductImagesUrls;
      updatedProduct.thumbnail =
          imagesController.selectedThumbnailImageUrl.value ?? '';
      updatedProduct.productAttributes =
          ProductAttributesController.instance.productAttributes;
      updatedProduct.productVariations = variations;
      updatedProduct.productVisibility = productVisibility.value.toString();

      productDataUploader.value = true;
      await ProductRepository.instance.updateProduct(updatedProduct);

      //Register product categories if any
      if (allSelectedCategories.isNotEmpty) {
        categoriesRelationshipUploader.value = true;

        List<String> existingCategoryIds = alreadyAddedCategories.map((category) => category.id).toList();
        for (var category in allSelectedCategories) {
          if(!existingCategoryIds.contains(category.id)){
            final productCategory = ProductCategoryModel(
                productId: updatedProduct.id, categoryId: category.id);
            await ProductRepository.instance
                .createProductCategory(productCategory);
          }
        }

        for(var existingCategoryId in existingCategoryIds){
          if(!allSelectedCategories.any((category) => category.id == existingCategoryId)){
            await ProductRepository.instance.deleteProductCategory(updatedProduct.id, existingCategoryId);
          }
        }
      } else {
        throw 'Select at least one category';
      }

      ProductController.instance.updateItemFromLists(updatedProduct);

      //Remove Loader
      TFullScreenLoader.stopLoading();
      showSuccessDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh bad', message: e.toString());
    }
  }

  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    description.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    selectedParentCategories.clear();
    selectedSubCategories.clear();
    alreadyAddedCategories.clear();
    ProductVariationsController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

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
          Text('Product Updated Successfully'),
        ],
      ),
    ));
  }
}