import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:restaurant_table_management/domains/order.dart';

import '../domains/menu.dart';
import '../domains/table.dart';

const String serviceBaseUrl =
    'http://10.0.2.2:50001/training-ws/api/v1/menuController';
const String mockUpUrl = 'assets/json/';
Future<List<Table>> getTableList() async {
  // final response = await get(Uri.parse('$serviceBaseUrl/tables'));
  final response = await rootBundle.loadString('assets/json/get_tables.json');

  var parsedJson = jsonDecode(response);
  List<Table> results =
      parsedJson.map<Table>((json) => Table.fromJson(json)).toList();

  return results;
}

Future<List<Menu>> getMenus() async {
  // final response = await get(Uri.parse('$serviceBaseUrl/tables'));
  final response = await rootBundle.loadString('assets/json/get_menu.json');

  var parsedJson = jsonDecode(response);
  List<Menu> results =
      parsedJson.map<Menu>((json) => Menu.fromJson(json)).toList();
  return results;
}

Future<Map<String, List<Order>>> getOrders() async {
  // final response = await get(Uri.parse('$serviceBaseUrl/tables'));
  final response = await rootBundle.loadString('assets/json/get_orders.json');
  var parsedJson = jsonDecode(response);
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
}  

 


//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     var parsedJson = jsonDecode(response.body);
//     print(parsedJson[0]);
//     List<Table> results =
//         parsedJson.map((table) => Table.fromJson(table)).toList();

//     return results;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load post');
//   }
// }
