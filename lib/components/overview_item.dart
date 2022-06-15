// With indicator
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

class OverviewItem extends StatelessWidget {
  const OverviewItem({
    Key? key,
    required this.title,
    required this.label,
    this.indicatorColor = kCompletedColor,
  }) : super(key: key);
  final String title;
  final String label;
  final Color indicatorColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.015,
          horizontal: MediaQuery.of(context).size.height * 0.0075),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        border: Border.all(color: indicatorColor.withOpacity(0.5), width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: kHeaderTextStyle,
            ),
            Text(
              label,
              style: kPrimaryTextStyle.copyWith(
                color: kSecondaryFontColor,
              ),
            )
          ]),
    );
  }
}
