import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

class ListHeader extends StatelessWidget {
  final String title;

  const ListHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: kHeaderTextStyle,
            )),
        // const Divider(
        //   color: kBorderColor,
        //   thickness: 2,
        // ),
      ],
    );
  }
}
