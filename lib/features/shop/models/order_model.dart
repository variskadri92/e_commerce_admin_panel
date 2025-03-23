import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/address_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/cart_item_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';

import '../../../utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.docId = '',
    this.userId = '',
    required this.status,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = 'Cash On Delivery',
    this.shippingAddress,
    this.billingAddress,
    this.billingAddressSameAsShipping = true,
    this.deliveryDate,
    required this.items,
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
        id: '',
        items: [],
        status: OrderStatus.pending,
        orderDate: DateTime.now(),
        totalAmount: 0.0,
        shippingCost: 0.0,
        taxCost: 0.0,
      );

  ///Convert model to JSon structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'billingAddress': billingAddress?.toJson(),
      'shippingAddress': shippingAddress?.toJson(),
      'deliveryDate': deliveryDate,
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  ///Factory method to create UserModel from Firebase document Snapshot.
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      docId: snapshot.id,
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status')
          ? OrderStatus.values.firstWhere((e) => e.toString() == data['status'])
          : OrderStatus.pending,
      totalAmount:
          data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0,
      shippingCost: data.containsKey('shippingCost')
          ? (data['shippingCost'] as num).toDouble()
          : 0.0,
      taxCost: data.containsKey('taxCost')
          ? (data['taxCost'] as num).toDouble()
          : 0.0,
      orderDate: data.containsKey('orderDate')
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod')
          ? data['paymentMethod'] as String
          : '',
      billingAddressSameAsShipping:
          data.containsKey('billingAddressSameAsShipping')
              ? data['billingAddressSameAsShipping'] as bool
              : true,
      billingAddress: data.containsKey('billingAddress')
          ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>)
          : AddressModel.empty(),
      shippingAddress: data.containsKey('shippingAddress')
          ? AddressModel.fromMap(
              data['shippingAddress'] as Map<String, dynamic>)
          : AddressModel.empty(),
      deliveryDate: data.containsKey('deliveryDate') && data['deliveryDate'] != null ? (data['deliveryDate'] as Timestamp).toDate() : null,

      items: (data['items'] as List<dynamic>)
          .map((itemData) =>
              CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
    );
  }
}
