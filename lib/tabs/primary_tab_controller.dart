import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/tabs/order_list_tab.dart';
import 'package:restaurant_table_management/tabs/table_list_tab.dart';

class PrimaryTab extends StatelessWidget {
  const PrimaryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(children: [
            TabBar(labelColor: kPrimaryFontColor, tabs: [
              Tab(text: 'Table'),
              Tab(text: 'Order'),
            ]),
            Expanded(
                child: TabBarView(
                    children: <Widget>[TableListTab(), OrderListTab()]))
          ]),
        ));
  }
}
