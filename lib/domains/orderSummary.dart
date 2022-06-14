import 'dart:convert';

import 'package:restaurant_table_management/domains/order.dart';

class OrderSummary {
  List<Order> orderList;
  double totalPrice;
  double discount;
  double finalPrice;
  DateTime checkInTime;
  DateTime checkOutTime;
  OrderSummary(
      {required this.orderList,
      required this.totalPrice,
      required this.finalPrice,
      required this.checkInTime,
      required this.checkOutTime,
      this.discount = 0});
  factory OrderSummary.fromJson(Map<String, dynamic> parsedJson) {
    return OrderSummary(
        discount: parsedJson['discount'] ?? 0,
        totalPrice: parsedJson['totalPrice'] ?? 0,
        finalPrice: parsedJson['finalPrice'] ?? 0,
        checkInTime: DateTime.parse(parsedJson['checkInTime']),
        checkOutTime: DateTime.parse(parsedJson['checkOutTime']),
        orderList: parsedJson['orderList']
            .map<Order>((e) => Order.fromJson(e))
            .toList());
  }
  OrderSummary.empty()
      : orderList = [],
        totalPrice = 0,
        finalPrice = 0,
        checkInTime = DateTime.now(),
        checkOutTime = DateTime.now(),
        discount = 0;

  Map<String, dynamic> toJson() {
    return {
      'discount': discount,
      'totalPrice': totalPrice,
      'finalPrice': finalPrice,
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime.toIso8601String(),
      'orderList': orderList,
    };
  }
}
