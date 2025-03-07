import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import '../../../utils/constants/enums.dart';
import '../models/order_model.dart';

// class DashboardController extends GetxController {
//   var filteredDataList = <Map<String, String>>[].obs;
//   var dataList = <Map<String, String>>[].obs;
//   RxList<bool> selectedRows = <bool>[].obs; // Track selected rows
//   RxInt sortColumnIndex = 1.obs; // Track sorted column index
//   RxBool sortAscending = true.obs; // Track sort order
//   final searchTextController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getData();
//   }
//
//   void sortById(int sortColumnIndex, bool ascending) {
//     sortAscending.value = ascending;
//     filteredDataList.sort((a, b) {
//       // if (ascending) {
//       //   return filteredDataList[0]['Column1']
//       //       .toString()
//       //       .toLowerCase()
//       //       .compareTo(filteredDataList[0]['Column1'].toString().toLowerCase());
//       // } else {
//       //   return filteredDataList[0]['Column1']
//       //       .toString()
//       //       .toLowerCase()
//       //       .compareTo(filteredDataList[0]['Column1'].toString().toLowerCase());
//       // }
//
//       if (ascending) {
//         return a['Column1']!
//             .toLowerCase()
//             .compareTo(b['Column1']!.toLowerCase());
//       } else {
//         return b['Column1']!
//             .toLowerCase()
//             .compareTo(a['Column1']!.toLowerCase());
//       }
//     });
//     this.sortColumnIndex.value = sortColumnIndex;
//   }
//
//   void searchQuery(String query) {
//     filteredDataList.assignAll(dataList
//         .where((item) => item['Column1']!.contains(query.toLowerCase())));
//   }
//
//   void getData() {
//     selectedRows.assignAll(
//         List.generate(36, (index) => false)); // Initialize selectedRows
//
//     dataList.addAll(List.generate(
//         36,
//             (index) => {
//           'Column1': 'Row ${index + 1}-1',
//           'Column2': 'Row ${index + 1}-2',
//           'Column3': 'Row ${index + 1}-3',
//           'Column4': 'Row ${index + 1}-4',
//         }));
//
//     filteredDataList.addAll(List.generate(
//         36,
//             (index) => {
//           'Column1': 'Row ${index + 1}-1',
//           'Column2': 'Row ${index + 1}-2',
//           'Column3': 'Row ${index + 1}-3',
//           'Column4': 'Row ${index + 1}-4',
//         }));
//   }
// }

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;

  /// Orders
  static final List<OrderModel> orders = [
    OrderModel(
      id: '0001',
      status: OrderStatus.processing,
      totalAmount: 1200.0,
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
      deliveryDate: DateTime.now().add(const Duration(days: 3)),
    ),
    OrderModel(
      id: '0002',
      status: OrderStatus.shipped,
      totalAmount: 1100,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
      deliveryDate: DateTime.now().add(const Duration(days: 3)),
    ),
    OrderModel(
      id: '0003',
      status: OrderStatus.delivered,
      totalAmount: 120.0,
      orderDate: DateTime.now().subtract(const Duration(days: 3)),
      deliveryDate: DateTime.now().add(const Duration(days: 3)),
    ),
    OrderModel(
      id: '0004',
      status: OrderStatus.cancelled,
      totalAmount: 600.0,
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now().add(const Duration(days: 3)),
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    super.onInit();
  }

  ///Calculate Weekly Sales
  void _calculateWeeklySales() {
    //Reset weekly sales to zero
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      final DateTime orderWeekStart =
          THelperFunctions.getStartOfWeek(order.orderDate);
      //Check if the order is within the current week

      if(orderWeekStart.isBefore(DateTime.now()) && orderWeekStart.add(Duration(days: 7)).isAfter(DateTime.now())){
        int index = (order.orderDate.weekday - 1) % 7;

        //Ensure index is non negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
        
        print('Order Date: ${order.orderDate}, Order Week Start: $orderWeekStart, Index: $index');
      }
    }

    print('Weekly Sales: $weeklySales');
  }
}
