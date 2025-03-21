import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/dialogs.dart';

class ProductVariationsController extends GetxController {
  static ProductVariationsController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  //List to store controller for each variation attribute
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>>
      descriptionControllersList = [];

  final attributesController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock controller
      Map<ProductVariationModel, TextEditingController> stockController = {};
      stockController[variation] =
          TextEditingController(text: variation.stock.toString());
      stockControllersList.add(stockController);

      // Price controller
      Map<ProductVariationModel, TextEditingController> priceController = {};
      priceController[variation] =
          TextEditingController(text: variation.price.toString());
      priceControllersList.add(priceController);

      // Sale price controller
      Map<ProductVariationModel, TextEditingController> salePriceController = {};
      salePriceController[variation] =
          TextEditingController(text: variation.salePrice.toString());
      salePriceControllersList.add(salePriceController);

      // Description controller
      Map<ProductVariationModel, TextEditingController> descriptionController = {};
      descriptionController[variation] =
          TextEditingController(text: variation.description);
      descriptionControllersList.add(descriptionController);
    }
  }


  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate Variations',
      onConfirm: () => generateVariationsFromAttributes(),
      content:
          'Once the variations are created, you cannot add more attributes. In order to add more variations, you have to delete any of the existing attributes.',
    );
  }

  void removeVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      confirmText: 'Delete',
      title: 'Delete Variations',
      onConfirm: () {
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  void generateVariationsFromAttributes() {
    Get.back();

    final List<ProductVariationModel> variations = [];

    //Check if there are attributes
    if (attributesController.productAttributes.isNotEmpty) {
      //Get all combination attribute values ,example [[Green,BLue],[Small,Large]]
      final List<List<String>> attributeCombinations = getCombinations(
          attributesController.productAttributes
              .map((attribute) => attribute.values ?? <String>[])
              .toList());

      //Generate ProductVariationsModel for each combination
      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
            attributesController.productAttributes
                .map((attr) => attr.name ?? ''),
            combination);

        //set default values for other properties if needed
        final ProductVariationModel variation = ProductVariationModel(
            id: UniqueKey().toString(), attributeValues: attributeValues);

        //Add variation to list
        variations.add(variation);

        //Create controllers
        Map<ProductVariationModel, TextEditingController> stockControllers = {};
        Map<ProductVariationModel, TextEditingController> priceControllers = {};
        Map<ProductVariationModel, TextEditingController> salePriceControllers =
            {};
        Map<ProductVariationModel, TextEditingController>
            descriptionControllers = {};

        //Assuming variation is your current ProductVariationModel
        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        //Add the maps to their respective lists
        stockControllersList.add(stockControllers);
        priceControllersList.add(priceControllers);
        salePriceControllersList.add(salePriceControllers);
        descriptionControllersList.add(descriptionControllers);

      }
    }

    //Assign the generated variations to the productVariation list
    productVariations.assignAll(variations);
  }

  void combine(List<List<String>> lists, int index, List<String> current,
      List<List<String>> result) {
    //If we have reached the end of the lists, add the current combination to the result
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    //Iterate over the values of current attribute
    for (final item in lists[index]) {
      //Create an updated list with the current item added
      final List<String> updated = List.from(current)..add(item);

      //Recursively combine with next attribute
      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    productVariations.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
  }

  List<List<String>> getCombinations(List<List<String>> list) {
    //The result list to store the combinations
    final List<List<String>> result = [];
    //Call the recursive function to generate combinations from first attribute
    combine(list, 0, [], result);
    return result;
  }
}
