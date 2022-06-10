import 'package:restaurant_table_management/domains/order.dart';

class OrderSummary {
  List<Order> orderList;
  double totalPrice;
  OrderSummary({required this.orderList, required this.totalPrice});
  factory OrderSummary.fromJson(Map<String, dynamic> parsedJson) {
    return OrderSummary(
        totalPrice: parsedJson['totalPrice'],
        orderList: parsedJson['orderList']
            .map<Order>((e) => Order.fromJson(e))
            .toList());
  }
}
