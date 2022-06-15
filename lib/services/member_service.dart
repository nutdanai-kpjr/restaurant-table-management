import 'dart:collection';
import 'dart:convert';

import 'package:restaurant_table_management/domains/order_summary.dart';
import 'package:restaurant_table_management/services/service.dart';
import 'package:http/http.dart' as http;
import '../domains/member.dart';

const String memberBaseUrl = '$baseUrl/api/v1/member';

Future<Member?> checkMembership(String phoneNumber, {required context}) async {
  final response = await http.post(Uri.parse(
    '$memberBaseUrl/getMemberInfoByPhoneNumber?phoneNumber=$phoneNumber',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var parsedJson = jsonDecode(response.body);
    Member member = Member.fromJson(parsedJson);
    return member;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return null;
    // }
    // }
  }
}

Future<bool> addMember(Member newMember, {required context}) async {
  final response = await http.post(
      Uri.parse(
        '$memberBaseUrl/registerMember',
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(newMember.toJson()));
  print(response);
  if (response.statusCode == 200) {
    return true;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return false;
  }
}

Future<OrderSummary?> applyMembershipToOrder(OrderSummary orderSummary,
    {required context}) async {
  final response = await http.post(Uri.parse(
    '$memberBaseUrl/applyMembershipToOrder',
  ));

  if (response.statusCode == 200) {
    return orderSummary;
  } else {
    var body = json.decode(response.body);
    await showErrorDialog(context, body);
    return null;
  }
}
