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
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: indicatorColor, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.0125,
        ),
        Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.0125),
          width: double.infinity,
          child: Text(
            title,
            style: kHeaderTextStyle,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.0125),
          width: double.infinity,
          child: Text(
            label,
            style: kPrimaryTextStyle.copyWith(
              color: kSecondaryFontColor,
            ),
          ),
        )
      ]),
    );
  }
}
