import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_table_management/domains/atm_transaction.dart';
import 'package:restaurant_table_management/services/service.dart';

const String bankBaseUrl = 'http://192.168.86.71:50001/bank'; // for emulator
// http://localhost:50001/training-ws/
const String bankControllerUrl = '$bankBaseUrl/api/v1/ATM/account';

Future<bool> payWithATMCard(ATMTransaction atmTransaction,
    {required context}) async {
  final response = await http.post(Uri.parse('$bankControllerUrl/chargeATM'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(atmTransaction));

  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}
