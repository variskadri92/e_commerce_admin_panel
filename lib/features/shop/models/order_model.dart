import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/cart_item_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/order/orders_detail/widgets/order_items.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';

import '../../../utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String paymentMethod;
  final List<CartItemModel> items;
  final String? image;
  final double? price;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'googlePay',
    this.deliveryDate,
    required this.items,
    this.price,
    this.image,


  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  static OrderModel empty() => OrderModel(
      status: OrderStatus.pending,
      totalAmount: 0.0,
      orderDate: DateTime.now(),
      id: '', items: []);

  ///Convert model to JSon structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'deliveryDate': deliveryDate,
    };
  }

  ///Factory method to create UserModel from Firebase document Snapshot.
  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OrderModel(
        id: document.id,
        status: OrderStatus.pending,
        totalAmount: 0.0,
        orderDate: DateTime.now(), items: [],
      );
    } else {
      return OrderModel.empty();
    }
  }
}
