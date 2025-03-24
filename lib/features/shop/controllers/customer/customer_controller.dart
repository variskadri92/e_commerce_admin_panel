import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';

class CustomerController extends BaseDataTableController<UserModel>{
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(UserRepository());

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }
  
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (UserModel o) => o.fullName.toString().toLowerCase());
  }

  @override
  Future<void> deleteItems(UserModel item) async{
    await _customerRepository.deleteUser(item.id ?? '');
  }

  @override
  Future<List<UserModel>> fetchItems() async{
    return await _customerRepository.getAllUsers();
  }
}