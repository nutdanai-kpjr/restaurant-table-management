// const String baseUrl = 'http://192.168.86.76:50001/restaurant';
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/constants.dart';

// const String baseUrl = 'http://localhost:50001/training-ws/';
// const String baseUrl = 'http://10.0.2.2:50001/restaurant'; // for emulator
const String baseUrl = "http://192.168.86.39:50001/restaurant";

const String mockUpUrl = 'assets/json/';

Future<void> showErrorDialog(context, body) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            body["error"] ?? "Unkown error",
            style: kHeaderTextStyle,
          ),
          content: Text(
            body["message"] ?? 'Something went wrong',
            style: kPrimaryTextStyle,
          ),
          actions: <Widget>[
            PrimaryButton(
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
