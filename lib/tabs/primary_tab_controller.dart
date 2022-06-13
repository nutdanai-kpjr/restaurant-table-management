import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/tabs/dashboard_tab.dart';
import 'package:restaurant_table_management/tabs/order_list_tab.dart';
import 'package:restaurant_table_management/tabs/table_list_tab.dart';

class PrimaryTab extends StatelessWidget {
  const PrimaryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                border: const Border(
                    bottom: BorderSide(color: kBorderColor, width: 1.0)),
              ),
              child: const TabBar(
                  indicatorColor: kThemeColor,
                  labelColor: kPrimaryFontColor,
                  labelStyle: kHeaderTextStyle,
                  unselectedLabelStyle: kHeaderTextStyle,
                  tabs: [
                    Tab(
                      text: 'Table',
                    ),
                    Tab(text: 'Order'),
                    Tab(text: 'Dashboard'),
                  ]),
            ),
            const Expanded(
                child: TabBarView(children: <Widget>[
              TableListTab(),
              OrderListTab(),
              DashBoardTab()
            ]))
          ]),
        ));
  }
}
