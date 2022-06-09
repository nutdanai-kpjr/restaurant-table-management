// Col ( OrderId, Row(tableId,Time))

import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/back_navigator_button.dart';
import 'package:restaurant_table_management/tabs/primary_tab_controller.dart';

/// Header
///   App Title
///   Tab Bar
///
class SecondaryHeader extends StatelessWidget {
  const SecondaryHeader(
      {Key? key,
      required this.title,
      required this.tableId,
      required this.time,
      this.onPressedBackButton})
      : super(key: key);
  final String title;
  final String tableId;
  final String time;
  final Function()? onPressedBackButton;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          BackNavigatorButton(onPressed: onPressedBackButton),
          Text(title),
          Row(
            children: [
              Text(tableId),
              Text(time),
            ],
          ),
        ],
      ),
      Divider(
        thickness: 3,
      ),
    ]);
  }
}
