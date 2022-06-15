import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/domains/order.dart';
import 'package:restaurant_table_management/domains/order_summary.dart';
import 'package:restaurant_table_management/services/service.dart';

import '../domains/menu.dart';
import '../domains/table.dart' as domain;

Future<List<domain.Table>> getTableList({required context}) async {
  final response = await get(Uri.parse('$restaurantBaseUrl/listTable'));
  // final response = await rootBundle.loadString('assets/json/get_tables.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<domain.Table> results = parsedJson
        .map<domain.Table>((table) => domain.Table.fromJson(table))
        .toList();

    return results;
  } else {
    var body = jsonDecode(response.body);
    await showErrorDialog(context, body);
    throw Exception('Failed to get table post');
  }
}

Future<List<Menu>> getMenus({required context}) async {
  final response = await get(Uri.parse('$restaurantBaseUrl/listMenu'));
  // final response = await rootBundle.loadString('assets/json/get_menu.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Menu> results =
        parsedJson.map<Menu>((menu) => Menu.fromJson(menu)).toList();

    return results;
  } else {
    var body = jsonDecode(response.body);
    await showErrorDialog(context, body);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
  }
}

Future<List<Order>> getOrderHistory({required context}) async {
  final response = await get(Uri.parse('$internalBaseUrl/getHistory'));

// final response = await rootBundle.loadString('assets/json/get_menu.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    List<Order> results = parsedJson
        .map<Order>((order) => Order.fromJson(order, isHistory: true))
        .toList();
    return results;
  } else {
    var body = jsonDecode(response.body);
    await showErrorDialog(context, body);
    return [];
    // If the server did not return a 200 OK response,
    // then throw an exception.

  }
}

Future<Map<String, List<Order>>> getOrders({required context}) async {
  final response = await get(Uri.parse('$restaurantBaseUrl/listOrder'));
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
    orderMap['hidden'] = await getOrderHistory(context: context);

    return orderMap;
  } else {
    var body = jsonDecode(response.body);
    await showErrorDialog(context, body);
    return {};
  }
}

Future<OrderSummary> getCheckoutOrders(String tableID,
    {required context}) async {
  final response = await post(Uri.parse(
    '$restaurantBaseUrl/checkOut?tableID=$tableID',
  ));

  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    OrderSummary result = OrderSummary.fromJson(parsedJson);
    return result;
  } else {
    var body = jsonDecode(response.body);
    await showErrorDialog(context, body);
    Navigator.maybePop(context);
    return OrderSummary.empty();
    // }
  }
}

Future<OrderSummary> getCheckOutOrdersWithMembership(String tableID,
    {required context,
    required String phoneNumber,
    required OrderSummary orderSummary}) async {
  final requestBody = json.encode({
    "wrapper": orderSummary,
    "phoneNumber": phoneNumber,
    "tableID": tableID
  });
  final response = await post(
      Uri.parse(
        '$restaurantBaseUrl/checkOutMember',
      ),
      headers: {"Content-Type": "application/json"},
      body: requestBody);

  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    OrderSummary result = OrderSummary.fromJson(parsedJson);
    return result;
  } else {
    var body = jsonDecode(response.body);
    await showErrorDialog(context, body);
    Navigator.maybePop(context);
    return OrderSummary.empty();
  }
}

Future<bool> confirmCheckout(String tableID, {required context}) async {
  final response = await post(Uri.parse(
    '$restaurantBaseUrl/exit?tableID=$tableID',
  ));
  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    return true;
  } else {
    var body = jsonDecode(response.body);
    await showErrorDialog(context, body);
    return false;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // }
  }
}

Future<bool> checkInTable(String tableID, {required context}) async {
  final response = await post(Uri.parse(
    '$restaurantBaseUrl/checkIn?tableID=$tableID',
  ));

  if (response.statusCode != 200) {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  } else {
    return true;
  }
  // final response = await rootBundle.loadString('assets/json/get_orders.json');
}

Future<bool> _updateOrder(String orderID, String status,
    {required context}) async {
  final response = await post(Uri.parse(
    '$restaurantBaseUrl/UpdateOrder?orderID=$orderID&orderStatus=$status',
  ));

  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);

    await showErrorDialog(context, body);
    return false;
    // }
  }
}

Future<bool> completeOrder(String orderID, {required context}) async {
  return await _updateOrder(orderID, 'COMPLETED', context: context);
}

Future<bool> cancelOrder(String orderID, {required context}) async {
  return await _updateOrder(orderID, 'CANCELED', context: context);
}

Future<bool> createOrder(String tableID, List<String> menuIdList,
    {required context}) async {
  Map<String, dynamic> mapBody = {
    'tableID': tableID,
    'menuList': menuIdList,
  };

  var body = json.encode(mapBody);

  final response = await post(
      Uri.parse(
        '$restaurantBaseUrl/order',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body);

  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;

    // }
  }
}

// Future<bool> updateChekoutPaymentmethod(){

// }
