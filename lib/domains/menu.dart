// Menu class with following attributes:
//  - id
//  - name
//  - price (integer)
//

import 'dart:convert';

class Menu {
  final String id;
  final String name;
  final double price;
  final String menuStatus;
  Menu(
      {required this.id,
      required this.name,
      required this.price,
      required this.menuStatus});
  Menu.fromJson(parsedJson)
      : id = parsedJson['menuID'],
        name = parsedJson['name'],
        price = parsedJson['price'] * 1.0,
        menuStatus = parsedJson['menuStatus'];

  Map<String, dynamic> toJson() {
    return {
      'menuID': id,
      'name': name,
      'price': price,
      'menuStatus': menuStatus,
    };
  }

  bool get isAvailable => menuStatus == 'IN_STOCK';
}
