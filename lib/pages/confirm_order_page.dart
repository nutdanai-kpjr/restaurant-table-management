// Table Header
// Order Summary List (List of OrderItem)
// Wide Button: Confrim

// On Confrim Order Button
// Post API request to create new order and push to new Order Page

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/primary_scaffold.dart';
import 'package:restaurant_table_management/pages/main_page.dart';

import '../components/buttons/wide_button.dart';
import '../components/headers/secondary_header.dart';
import '../domains/menu.dart';

class ConfirmOrderPage extends StatefulWidget {
  ConfirmOrderPage({Key? key, required this.menus}) : super(key: key);
  final List<Menu> menus;
  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  late List<Menu> menus;
  @override
  void initState() {
    menus = widget.menus;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: WideButton(
          title: 'Confirm',
          onPressed: () {
            // Add API request here
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ),
        body: Column(children: [
          SecondaryHeader(
            title: "New Order",
            tableId: 'T001',
            time: '3 Jun | 14.00',
            onPressedBackButton: () {
              Navigator.pop(context, widget.menus);
            },
          ),
          Text('Order Summary'),
          Text('Selected Menu Item')
        ]));
  }
}
