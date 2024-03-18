import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Model/AddressModel.dart';
import 'package:dummy1/Model/Usermodel.dart';
import '../Controller/OrderController.dart';
import 'CartModel.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final AddressModel? address;
  final List<CartModel> items;
  final String paymentMethod;

  OrderModel({
    this.userId = '',
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.address,
    required this.items,
    this.paymentMethod = 'Paytm',
  });

  String get formattedOrderDate => formatter.formatDate(orderDate);

  String get orderStatusText =>
      status == OrderStatus.pending ? 'Delivered' : 'Not Delivered';

  static OrderModel empty() => OrderModel(
      id: '',
      status: OrderStatus.pending,
      totalAmount: 0,
      orderDate: '' as DateTime,
      items: []);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Status': status.toString(),
      'TotalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'Address': address?.toJson(),
      'orderDate': orderDate,
      'Items': items.map((e) => e.toJson()).toList(),
    };
  }


  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data()!;
      return OrderModel(
        id: data['Id'] as String,
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == data['Status']),
        totalAmount: data['TotalAmount'] as double,
        paymentMethod: data['paymentMethod'] as String,
        orderDate: (data['orderDate'] as Timestamp).toDate(),
        items: (data['Items'] as List<dynamic>)
            .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        address: AddressModel.fromMap(data['Address'] as Map<String, dynamic>),
      );
    } else {
      return OrderModel.empty();
    }
  }
}
