import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';

import '../../../../data/repositories/products/product_repository.dart';

class ProductController extends BaseDataTableController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||
        item.price.toString().contains(query);
  }

  ///Sorting related code
  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending,
        (ProductModel product) => product.title.toLowerCase());
  }

  void sortByPrice(int columnIndex, bool ascending) {
    sortByProperty(
        columnIndex, ascending, (ProductModel product) => product.price);
  }

  void sortByStock(int columnIndex, bool ascending) {
    sortByProperty(
        columnIndex, ascending, (ProductModel product) => product.stock);
  }

  void sortBySoldItems(int columnIndex, bool ascending) {
    sortByProperty(
        columnIndex, ascending, (ProductModel product) => product.soldQuantity);
  }

  ///Get the product price or price range for variations
  String getProductPrice(ProductModel product) {
    //If no variation exist, return the single price or sale
    if (product.productType == ProductType.single.toString() ||
        product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;

      //Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        //Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      //If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - $largestPrice';
      }
    }
  }

  ///Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return null;
    }
    if (originalPrice <= 0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  ///Calculate Product Stock
  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.stock.toString()
        : product.productVariations!
            .fold<int>(0, (sum, variation) => sum + variation.stock)
            .toString();
  }

  ///Calculate Product Sold Quantity
  String getProductSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.soldQuantity.toString()
        : product.productVariations!
            .fold<int>(0, (sum, variation) => sum + variation.soldQuantity)
            .toString();
  }

  ///Check product stock status
  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  @override
  Future<void> deleteItems(ProductModel item) async {
    //add check if any order is associated with this product
    await _productRepository.deleteProduct(item);
  }
}
