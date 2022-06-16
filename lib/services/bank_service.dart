import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_table_management/domains/atm_transaction.dart';
import 'package:restaurant_table_management/domains/rabbit_transaction.dart';
import 'package:restaurant_table_management/services/service.dart';

const String bankBaseUrl = 'http://10.0.2.2:50001/training-ws/'; // for emulator
// http://localhost:50001/training-ws/
const String bankControllerUrl = '$bankBaseUrl/api/v1/rabbit';

Future<bool> payWithATMCard(ATMTransaction atmTransaction,
    {required context}) async {
  final response = await http.post(Uri.parse('$bankControllerUrl/atmpay'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(atmTransaction));

  print(response);
  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}
