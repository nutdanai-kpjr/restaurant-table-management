// Col ( OrderId, Row(tableId,Time))

import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/back_navigator_button.dart';
import 'package:restaurant_table_management/constants.dart';
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
    return Column(
      children: [
        SizedBox(
          height: 4,
        ),
        BackNavigatorButton(onPressed: onPressedBackButton),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  width: double.infinity,
                  child: Text(
                    title,
                    style:
                        kHeaderTextStyle.copyWith(fontSize: kAppTitleFontSize),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tableId,
                        style: kHeaderTextStyle.copyWith(
                            color: kSecondaryFontColor,
                            fontWeight: FontWeight.normal)),
                    Text(
                      time,
                      style: kHeaderTextStyle.copyWith(
                          color: kSecondaryFontColor,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: kPrimaryFontColor,
              thickness: 1,
            ),
          ]),
        ),
      ],
    );
  }
}
