// Table Header
// Order Summary List (List of OrderItem)
// Wide Button: Confrim

// On Confrim Order Button
// Post API request to create new order and push to new Order Page

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/primary_scaffold.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/pages/create_order_page.dart';
import 'package:restaurant_table_management/pages/main_page.dart';
import 'package:restaurant_table_management/services/service.dart';

import '../components/buttons/wide_button.dart';
import '../components/headers/secondary_header.dart';
import '../domains/menu.dart';
import '../services/restaurant_service.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage(
      {Key? key, required this.selectedMenusQuantity, required this.tableID})
      : super(key: key);
  final String tableID;
  final Map<String, int> selectedMenusQuantity;
  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  late List<Menu> menus;
  late Map<String, int> selectedMenusQuantity;
  late String tableID;
  @override
  void initState() {
    selectedMenusQuantity = widget.selectedMenusQuantity;
    tableID = widget.tableID;
    super.initState();
  }

  void _updateSelectedMenusQuantity(newValue) {
    setState(() {
      selectedMenusQuantity = newValue;
    });
  }

  // _onConfirm() {}

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: WideButton(
            title: 'Confirm',
            onPressed: () async {
              List<String> menuIdList = [];

              selectedMenusQuantity.forEach((key, value) {
                for (int i = 0; i < value; i++) {
                  menuIdList.add(key);
                }
              });
              createOrder(tableID, menuIdList, context: context).then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              });
              // Add API request here
            }),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kWidth(context) * 0.03),
          child: Column(children: [
            SecondaryHeader(
              title: "Confirm Order",
              tableId: 'Table: $tableID',
              time: DateTime.now().toString().substring(0, 16),
              onPressedBackButton: () {
                Navigator.pop(context, selectedMenusQuantity);
              },
            ),
            MenuList(
                showSelectedOnly: true,
                selectedMenusQuantity: selectedMenusQuantity,
                onUpdateSelectedMenusQuantity: _updateSelectedMenusQuantity)
          ]),
        ));
  }
}
