import 'package:flutter/material.dart';
import 'package:restaurant_table_management/tabs/primary_tab_controller.dart';

/// Header
///   App Title
///   Tab Bar
///
class PrimaryHeader extends StatelessWidget {
  const PrimaryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [Text('Food Ninja')]);
  }
}
