import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_table_management/domains/order.dart';
import 'package:restaurant_table_management/services/service.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String internalBaseUrl = '$baseUrl/api/v1/internal';

Future<List<Order>> getOrderHistory({required context}) async {
  final response = await http.get(Uri.parse('$internalBaseUrl/getHistory'));

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

Future<bool> downloadReport() async {
  // String filePath = '/storage/emulated/0/Downloads/report.csv';

  return await launchUrlString(
    '$internalBaseUrl/getWeekReport',
    mode: LaunchMode.externalApplication,
  );
}
