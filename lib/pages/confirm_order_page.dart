// Table Header
// Order Summary List (List of OrderItem)
// Wide Button: Confrim

// On Confrim Order Button
// Post API request to create new order and push to new Order Page

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/primary_scaffold.dart';
import 'package:restaurant_table_management/pages/create_order_page.dart';
import 'package:restaurant_table_management/pages/main_page.dart';

import '../components/buttons/wide_button.dart';
import '../components/headers/secondary_header.dart';
import '../domains/menu.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({Key? key, required this.selectedMenusQuantity})
      : super(key: key);

  final Map<String, int> selectedMenusQuantity;
  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  late List<Menu> menus;
  late Map<String, int> selectedMenusQuantity;
  @override
  void initState() {
    selectedMenusQuantity = widget.selectedMenusQuantity;
    super.initState();
  }

  void _updateSelectedMenusQuantity(newValue) {
    setState(() {
      selectedMenusQuantity = newValue;
    });
  }

  _onConfirm() {}
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
              Navigator.pop(context, selectedMenusQuantity);
            },
          ),
          Text('Order Summary'),
          MenuList(
              showSelectedOnly: true,
              selectedMenusQuantity: selectedMenusQuantity,
              onUpdateSelectedMenusQuantity: _updateSelectedMenusQuantity)
        ]));
  }
}
