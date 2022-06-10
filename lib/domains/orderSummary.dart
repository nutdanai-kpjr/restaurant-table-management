import 'package:restaurant_table_management/domains/order.dart';

class OrderSummary {
  List<Order> orderList;
  int totalPrice;
  OrderSummary({required this.orderList, required this.totalPrice});
  factory OrderSummary.fromJson(Map<String, dynamic> parsedJson) {
    return OrderSummary(
      orderList:
          parsedJson['listOrder'].map<Order>((e) => Order.fromJson(e)).toList(),
      totalPrice: parsedJson['totalPrice'],
    );
  }
}
