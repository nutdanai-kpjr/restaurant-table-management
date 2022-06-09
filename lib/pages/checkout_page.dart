// Table Header
// List of Checkout Summary
// Divider
// Total
// Wide Button: Checkout

import 'package:flutter/material.dart';
import 'package:restaurant_table_management/pages/main_page.dart';

import '../components/buttons/wide_button.dart';
import '../components/headers/Secondary_header.dart';
import '../components/primary_scaffold.dart';

/// Use getCheckOutItems from TabeleProvider

// On Checkout Button
// Post Checkout API and push to Table Page

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key, required this.tableID}) : super(key: key);
  final String tableID;
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
            title: "Checkout",
            tableId: tableID,
            time: '3 Jun | 14.00',
          ),
          Text('Checkout Summary'),
          Text('CheckoutItem List ')
        ]));
  }
}
