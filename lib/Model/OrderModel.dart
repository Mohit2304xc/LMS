import 'dart:convert';
import 'package:dummy1/Model/Usermodel.dart';
import '../Controller/OrderController.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final String totalAmount;
  final DateTime orderDate;
  final String address;
  final List<String> items;
  final String paymentMethod;

  OrderModel({
    this.userId = '',
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.address,
    required this.items,
    this.paymentMethod = 'Paytm',
  });

  String get formattedOrderDate => formatter.formatDate(orderDate);

  String get orderStatusText =>
      status == OrderStatus.pending ? 'Delivered' : 'Not Delivered';

  static OrderModel empty() => OrderModel(
      id: '',
      status: OrderStatus.pending,
      totalAmount: '',
      orderDate: DateTime(1970),
      items: [],
      address: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      "user_id": userId.toString(),
      'status': status.toString(),
      'payment_method': paymentMethod,
      'total_amount': totalAmount.toString(),
      'date_time': orderDate.toIso8601String(),
      'items': jsonEncode(items),
      'address': address,
    };
  }

  static OrderStatus _parseOrderStatus(String status) {
    switch (status) {
      case 'OrderStatus.pending':
        return OrderStatus.pending;
    // Add more cases for other status values if needed
      default:
        throw ArgumentError('Invalid order status: $status');
    }
  }

  factory OrderModel.fromJson(Map<String, dynamic> document) {
    List<String> items = List<String>.from(document["items"]);
    return OrderModel(
      id: document["id"].toString(),
      userId: document["user_id"].toString(),
      status: _parseOrderStatus(document["status"]),
      totalAmount: document["total_amount"],
      orderDate: DateTime.parse(document["date_time"]),
      paymentMethod: document["payment_method"],
      items: items,
      address: document["address"] ?? "",
    );
  }


/*factory OrderModel.fromSnapshot(
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
  }*/
}
