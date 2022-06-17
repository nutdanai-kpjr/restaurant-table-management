import 'package:restaurant_table_management/domains/order.dart';

//Available Paymentmethod CASH, RABBIT_CARD, CREDIT_CARD
class OrderSummary {
  List<Order> orderList;
  double totalPrice;
  double discount;
  double finalPrice;
  double charge;
  DateTime checkInTime;
  DateTime checkOutTime;
  String paymentMethod;
  OrderSummary(
      {required this.orderList,
      required this.totalPrice,
      required this.finalPrice,
      required this.checkInTime,
      required this.checkOutTime,
      this.charge = 0,
      this.paymentMethod = "CASH",
      this.discount = 0});
  factory OrderSummary.fromJson(Map<String, dynamic> parsedJson) {
    return OrderSummary(
        discount: parsedJson['discount'] ?? 0,
        totalPrice: parsedJson['totalPrice'] ?? 0,
        finalPrice: parsedJson['finalPrice'] ?? parsedJson['totalPrice'] ?? 0,
        charge: parsedJson['charge'] ?? 0,
        checkInTime: DateTime.parse(parsedJson['checkInTime']),
        checkOutTime: DateTime.parse(parsedJson['checkOutTime']),
        paymentMethod: parsedJson['paymentMethod'] ?? "CASH",
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
        discount = 0,
        charge = 0,
        paymentMethod = "CASH";

  Map<String, dynamic> toJson() {
    return {
      'discount': discount,
      'totalPrice': totalPrice,
      'finalPrice': finalPrice,
      'charge': charge,
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime.toIso8601String(),
      'paymentMethod': paymentMethod,
      'orderList': orderList,
    };
  }
}
