import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';

class OrderModel {
  final String? id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? deliveryDate;

  OrderModel({
    this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.deliveryDate,
  });

  static OrderModel empty() => OrderModel(status: OrderStatus.pending,totalAmount: 0.0, orderDate: DateTime.now());

  ///Convert model to JSon structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Status': status.name.toString(),
      'TotalAmount': totalAmount,
      'OrderDate': orderDate,
      'DeliveryDate': deliveryDate,
    };
  }

  ///Factory method to create UserModel from Firebase document Snapshot.
  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OrderModel(
        id: document.id, status: OrderStatus.pending, totalAmount: 0.0, orderDate: DateTime.now(),


      );
    } else {
      return OrderModel.empty();
    }
  }
}
