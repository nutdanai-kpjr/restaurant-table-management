// With indicator
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/services/restaurant_service.dart';
import 'package:restaurant_table_management/services/service.dart';

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
        margin: EdgeInsets.all(kHeight(context) * 0.015),
        // height: kHeight(context) * 0.2,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: indicatorColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14.5),
                        bottomLeft: Radius.circular(14.5),
                      )),
                )),
            Expanded(
              flex: 26,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(
                      height: kHeight(context) * 0.0125,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: kHeight(context) * 0.0125),
                      width: double.infinity,
                      child: Text(
                        title,
                        style: kHeaderTextStyle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: kHeight(context) * 0.0125),
                      width: double.infinity,
                      child: Text(
                        status,
                        style: kPrimaryTextStyle.copyWith(
                          color: kSecondaryFontColor,
                        ),
                      ),
                    )
                  ]),
                  Column(
                    children: [
                      ...buttons,
                      SizedBox(
                        height: kHeight(context) * 0.0125,
                      ),
                    ],
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
  _onCheckIn(context) {
    checkInTable(tableID, context: context);

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
            onPressed: () async {
              await _onCheckIn(context);
            },
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
