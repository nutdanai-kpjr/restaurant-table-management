import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_table_management/domains/rabbit_transaction.dart';
import 'package:restaurant_table_management/services/service.dart';

const String rabbitCardbaseUrl =
    'http://192.168.86.80:50001/bts'; // for emulator
// http://localhost:50001/training-ws/
const String rabbitControllerUrl = '$rabbitCardbaseUrl/api/v1/rabbit';

Future<bool> payWithRabbitCard(RabbitTransaction rabbitTransaction,
    {required context}) async {
  final response = await http.post(Uri.parse('$rabbitControllerUrl/rabbitPay'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(rabbitTransaction));

  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}



// RESTAURANT
// rabbitID: SHOP222222
// rabbitPass: 1111
