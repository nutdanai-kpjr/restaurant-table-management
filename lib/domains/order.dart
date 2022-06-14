// Order Class with following attributes:
// - id
// - name
// - status (Enum: pending,completed,canceled,hidden)
// - tableId(null if it's history)
// - List<Menu>
// - price (double)

import 'dart:convert';

import 'package:restaurant_table_management/domains/menu.dart';

class Order {
  final String id;
  final String status;
  final String tableId;
  final String? memberId;
  final List<Menu> menuList;
  final int price;
  final bool isHistory;
  final DateTime startTime;
  final DateTime? updateTime;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  Order({
    required this.id,
    required this.status,
    required this.tableId,
    required this.menuList,
    required this.price,
    this.isHistory = false,
    this.memberId,
    required this.startTime,
    this.updateTime,
    required this.checkInTime,
    required this.checkOutTime,
  });
  Order.fromJson(parsedJson, {this.isHistory = false})
      : id = parsedJson['orderID'],
        status = parsedJson['orderStatus'],
        tableId = parsedJson['tableID'],
        menuList =
            parsedJson['menuOrder'].map<Menu>((e) => Menu.fromJson(e)).toList(),
        price = parsedJson['orderPrice'],
        startTime = DateTime.parse(parsedJson['startTime']),
        updateTime = parsedJson['updateTime'] != null
            ? DateTime.parse(parsedJson['updateTime'])
            : null,
        checkInTime = parsedJson['checkInTime'] != null
            ? DateTime.parse(parsedJson['checkInTime'])
            : null,
        checkOutTime = parsedJson['checkOutTime'] != null
            ? DateTime.parse(parsedJson['checkOutTime'])
            : null,
        memberId = parsedJson['memberID'];

  Map<String, dynamic> toJson() {
    return {
      'orderID': id,
      'orderStatus': status,
      'tableID': tableId,
      'menuOrder': menuList,
      'orderPrice': price,
      'startTime': startTime.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'memberID': memberId,
    };
  }
}
