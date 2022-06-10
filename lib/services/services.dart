import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:restaurant_table_management/domains/order.dart';
import 'package:restaurant_table_management/domains/orderSummary.dart';

import '../domains/menu.dart';
import '../domains/table.dart';

const String serviceBaseUrl =
    'http://192.168.86.76:50001/restaurant/api/v1/restaurant';
const String mockUpUrl = 'assets/json/';
Future<List<Table>> getTableList() async {
  final response = await get(Uri.parse('$serviceBaseUrl/listTable'));
  // final response = await rootBundle.loadString('assets/json/get_tables.json');

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
      'cancelled': [],
      'hidden': []
    };
    orderMap['pending'] =
        results.where((element) => element.status == 'PENDING').toList();
    orderMap['completed'] =
        results.where((element) => element.status == 'COMPLETED').toList();
    orderMap['cancelled'] =
        results.where((element) => element.status == 'CANCELLED').toList();
    orderMap['hidden'] =
        results.where((element) => element.status == 'HIDDEN').toList();
    return orderMap;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
  }
}

Future<OrderSummary> getCheckoutOrders(String tableID) async {
  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');

  final response = await post(
      Uri.parse(
        '$serviceBaseUrl/checkOut/$tableID',
      ),
  print(response.body);
  // final response = await rootBundle.loadString('assets/json/get_orders.json');
  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   var parsedJson = jsonDecode(response.body);
  //   OrderSummary result = OrderSummary.fromJson(parsedJson);
  //   return result;
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load post');
  // }
  return OrderSummary(totalPrice: 0, orderList: []);
}  
//  Future<void> che


//  
