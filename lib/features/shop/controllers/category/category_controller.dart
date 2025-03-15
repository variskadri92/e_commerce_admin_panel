import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/category_model.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() {
    try{
      isLoading.value = true;
      if(allItems.isEmpty){

      }
    }catch(e){}
  }
}