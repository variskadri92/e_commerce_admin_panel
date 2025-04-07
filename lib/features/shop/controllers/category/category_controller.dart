import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';

import '../../../../data/repositories/category/category_repository.dart';

class CategoryController extends BaseDataTableController<CategoryModel> {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(CategoryModel item) async {
    await _categoryRepository.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.getAllCategories();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (CategoryModel category) => category.name.toLowerCase());
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (CategoryModel category) => category.createdAt);
  }
}
