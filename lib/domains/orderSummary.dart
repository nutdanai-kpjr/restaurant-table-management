import 'package:restaurant_table_management/domains/order.dart';

class OrderSummary {
  List<Order> orderList;
  double totalPrice;
  double totalDiscount;
  OrderSummary(
      {required this.orderList,
      required this.totalPrice,
      this.totalDiscount = 0});
  factory OrderSummary.fromJson(Map<String, dynamic> parsedJson) {
    return OrderSummary(
        totalDiscount: parsedJson['totalDiscount'] ?? 0,
        totalPrice: parsedJson['totalPrice'],
        orderList: parsedJson['orderList']
            .map<Order>((e) => Order.fromJson(e))
            .toList());
  }

  double get totalPriceWithDiscount => totalPrice - totalDiscount;
}
