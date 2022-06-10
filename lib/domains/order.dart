// Order Class with following attributes:
// - id
// - name
// - status (Enum: pending,completed,canceled,hidden)
// - tableId(null if it's history)
// - List<Menu>
// - price (double)

import 'package:restaurant_table_management/domains/menu.dart';

class Order {
  final String id;
  final String status;
  final String? tableId;
  final List<Menu> menuList;
  final int price;

  Order({
    required this.id,
    required this.status,
    this.tableId,
    required this.menuList,
    required this.price,
  });
  Order.fromJson(parsedJson)
      : id = parsedJson['orderID'],
        status = parsedJson['orderStatus'],
        tableId = parsedJson['tableID'],
        menuList =
            parsedJson['menuOrder'].map<Menu>((e) => Menu.fromJson(e)).toList(),
        price = parsedJson['orderPrice'];

  void test() {}
}

enum OrderStatus {
  pending,
  completed,
  canceled,
  hidden,
}
