// With indicator
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/services/services.dart';

import '../pages/checkout_page.dart';
import '../pages/create_order_page.dart';

class TableItem extends StatelessWidget {
  const TableItem({
    Key? key,
    required this.status,
    required this.title,
    required this.buttons,
    required this.indicatorColor,
  }) : super(key: key);
  final String status;
  final String title;
  final List<Widget> buttons;
  final Color indicatorColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: indicatorColor,
                )),
            Expanded(
              flex: 25,
              child: Column(
                children: [
                  Column(children: [Text(title), Text(status)]),
                  Column(
                    children: buttons,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class AvaliableTableItem extends StatelessWidget {
  const AvaliableTableItem({
    Key? key,
    required this.tableID,
    this.refresh,
  }) : super(key: key);
  final String tableID;
  final Function()? refresh;
  _onCheckIn() {
    checkInTable(tableID);

    ///ADD API POST REQUEST FOR UPDATE TABLE HERE
    refresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    return TableItem(
        status: 'Avaliable',
        title: tableID,
        buttons: [
          PrimaryButton(
            text: 'Check In',
            onPressed: _onCheckIn,
          )
        ],
        indicatorColor: kCompletedColor);
  }
}

class InuseTableItem extends StatelessWidget {
  const InuseTableItem({Key? key, required this.tableID, this.refresh})
      : super(key: key);
  final String tableID;
  final Function()? refresh;

  _callRefresh() {
    refresh?.call();
  }

  _routeToCreateNewOrderPage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateOrderPage(
                  tableID: tableID,
                ))).then((value) => _callRefresh);
  }

  _routeToCheckoutPage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckOutPage(
                  tableID: tableID,
                ))).then((value) => _callRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return TableItem(
        status: 'In use',
        title: tableID,
        buttons: [
          PrimaryButton(
            text: 'New Order',
            onPressed: () {
              _routeToCreateNewOrderPage(context);
            },
          ),
          PrimaryButton(
            text: 'Check out',
            onPressed: () {
              _routeToCheckoutPage(context);
            },
          )
        ],
        indicatorColor: kInprogressColor);
  }
}
