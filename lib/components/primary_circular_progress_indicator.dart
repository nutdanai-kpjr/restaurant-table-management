import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

class PrimaryCircularProgressIndicator extends StatelessWidget {
  const PrimaryCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: kThemeColor,
    );
  }
}
