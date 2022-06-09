// Table class with following attributes:
// - id
// - status (Enum: avaliable,inused)
// - totalPrice (double)
// - List<Order>

import 'package:restaurant_table_management/domains/order.dart';

class Table {
  final String id;
  final String status;
  final double totalPrice;
  final List<Order> orderList;

  Table(
      {required this.id,
      required this.status,
      required this.totalPrice,
      required this.orderList});
  factory Table.fromJson(Map<String, dynamic> parsedJson) {
    return Table(
        id: parsedJson['tableID'],
        status: parsedJson['status'],
        totalPrice: parsedJson['totalPrice'],
        orderList: parsedJson['orderList']
            .map<Order>((e) => Order.fromJson(e))
            .toList());
  }
}
