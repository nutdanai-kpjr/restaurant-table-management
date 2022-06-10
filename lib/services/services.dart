import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:restaurant_table_management/domains/order.dart';
import 'package:restaurant_table_management/domains/orderSummary.dart';

import '../domains/menu.dart';
import '../domains/table.dart';

const String serviceBaseUrl =
    'http://192.168.86.76:50001/restaurant/api/v1/restaurant';

const String internalSerivceBaseUrl =
    'http://192.168.86.76:50001/restaurant/api/v1/internal';

const String mockUpUrl = 'assets/json/';
Future<List<Table>> getTableList() async {
  final response = await get(Uri.parse('$serviceBaseUrl/listTable'));
  // final response = await rootBundle.loadString('assets/json/get_tables.json');
  print('fire');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Table> results =
        parsedJson.map<Table>((table) => Table.fromJson(table)).toList();

    return results;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
  }
}

Future<List<Menu>> getMenus() async {
  final response = await get(Uri.parse('$serviceBaseUrl/listMenu'));
  // final response = await rootBundle.loadString('assets/json/get_menu.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Menu> results =
        parsedJson.map<Menu>((menu) => Menu.fromJson(menu)).toList();

    return results;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
  }
}

Future<List<Order>> getOrderHistory() async {
  final response =
      await get(Uri.parse('$internalSerivceBaseUrl/getHistoryOrder'));

// final response = await rootBundle.loadString('assets/json/get_menu.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Order> results =
        parsedJson.map<Order>((order) => Order.fromJson(order)).toList();
    return results;
  } else {
    return [];
    // If the server did not return a 200 OK response,
    // then throw an exception.

  }
}

Future<Map<String, List<Order>>> getOrders() async {
  final response = await get(Uri.parse('$serviceBaseUrl/listOrder'));
  // final response = await rootBundle.loadString('assets/json/get_menu.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Order> results =
        parsedJson.map<Order>((json) => Order.fromJson(json)).toList();

    Map<String, List<Order>> orderMap = {
      'pending': [],
      'completed': [],
      'canceled': [],
      'hidden': [],
    };
    orderMap['pending'] =
        results.where((element) => element.status == 'PENDING').toList();
    orderMap['completed'] =
        results.where((element) => element.status == 'COMPLETED').toList();
    orderMap['canceled'] =
        results.where((element) => element.status == 'CANCELED').toList();
    orderMap['hidden'] = await getOrderHistory();
    print(orderMap);
    return orderMap;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
  }
}

Future<OrderSummary> getCheckoutOrders(String tableID) async {
  final response = await post(Uri.parse(
    '$serviceBaseUrl/checkOut?tableID=$tableID',
  ));

  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    OrderSummary result = OrderSummary.fromJson(parsedJson);
    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
    // }
  }
}

Future<bool> confirmCheckout(String tableID) async {
  final response = await post(Uri.parse(
    '$serviceBaseUrl/exit?tableID=$tableID',
  ));
  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to check out');
    // }
  }
}

Future<bool> checkInTable(String tableID) async {
  final response = await post(Uri.parse(
    '$serviceBaseUrl/checkIn?tableID=$tableID',
  ));

  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to check in');
    // }
  }
}

Future<bool> _updateOrder(String orderID, String status) async {
  final response = await post(Uri.parse(
    '$serviceBaseUrl/UpdateOrder?orderID=$orderID&orderStatus=$status',
  ));
  print(response.body);
  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update order');
    // }
  }
}

Future<bool> completeOrder(String orderID) async {
  return await _updateOrder(orderID, 'COMPLETED');
}

Future<bool> cancelOrder(String orderID) async {
  return await _updateOrder(orderID, 'CANCELED');
}

Future<bool> createOrder(String tableID, List<String> menuIdList) async {
  Map<String, dynamic> mapBody = {
    'tableID': tableID,
    'menuList': menuIdList,
  };

  var body = json.encode(mapBody);
  print(body);
  final response = await post(
      Uri.parse(
        '$serviceBaseUrl/order',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body);

  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to create order');
    // }
  }
}
