import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/headers/primary_header.dart';
import 'package:restaurant_table_management/components/primary_scaffold.dart';
import 'package:restaurant_table_management/tabs/primary_tab_controller.dart';

/// App Bar
/// 5 Table

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        body: Column(
      children: const [
        Expanded(flex: 1, child: PrimaryHeader()),
        Expanded(flex: 8, child: PrimaryTab())
      ],
    ));
  }
}
