// const String baseUrl = 'http://192.168.86.76:50001/restaurant';
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';

const String baseUrl = 'http://10.0.2.2:50001/training-ws/'; // for emulator
// http://localhost:50001/training-ws/
const String restaurantBaseUrl = '$baseUrl/api/v1/restaurant';

const String internalBaseUrl = '$baseUrl/api/v1/internal';

const String mockUpUrl = 'assets/json/';

Future<void> showErrorDialog(context, body) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(body["error"] ?? "Unkown error"),
          content: Text(body["message"] ?? 'Something went wrong'),
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
