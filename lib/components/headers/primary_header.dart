import 'package:flutter/material.dart';
import 'package:restaurant_table_management/tabs/primary_tab_controller.dart';

import '../../constants.dart';

/// Header
///   App Title
///   Tab Bar
///
class PrimaryHeader extends StatelessWidget {
  const PrimaryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kThemeColor,
      child: Row(children: const [
        Expanded(
          child: Text('Food Ninja',
              style: kAppTitleTextStyle, textAlign: TextAlign.center),
        )
      ]),
    );
  }
}
