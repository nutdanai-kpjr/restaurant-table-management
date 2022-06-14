import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/components/buttons/wide_button.dart';
import 'package:restaurant_table_management/components/headers/list_header.dart';
import 'package:restaurant_table_management/components/order_detail.dart';
import 'package:restaurant_table_management/components/overview_item.dart';
import 'package:restaurant_table_management/components/primary_list_item.dart';
import 'package:restaurant_table_management/components/secondary_list_item.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/domains/order.dart';
import 'package:restaurant_table_management/services/service.dart';

import '../components/primary_circular_progress_indicator.dart';

class DashBoardTab extends StatefulWidget {
  const DashBoardTab({Key? key}) : super(key: key);

  @override
  State<DashBoardTab> createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> {
  List<bool> overviewMode = [true, false, false];

  late Future<Map<String, List<Order>>> _getOrderList;

  @override
  void initState() {
    super.initState();
    _getOrderList = getOrders(context: context);
  }

  _refetch() {
    setState(() {
      _getOrderList = getOrders(context: context);
    });
  }

  _buildOverviewModeSelection() {
    return ToggleButtons(
      renderBorder: false,
      fillColor: Colors.transparent,
      selectedColor: kPrimaryFontColor,
      splashColor: Colors.transparent,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < overviewMode.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              overviewMode[buttonIndex] = true;
            } else {
              overviewMode[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: overviewMode,
      children: <Widget>[
        PrimaryButton(
          text: 'Today',
          color: overviewMode[0] ? kCompletedColor : kBorderColor,
        ),
        PrimaryButton(
          text: 'This Week',
          color: overviewMode[1] ? kCompletedColor : kBorderColor,
        ),
        PrimaryButton(
          text: 'This Month',
          color: overviewMode[2] ? kCompletedColor : kBorderColor,
        ),
      ],
    );
  }

  _buildOverviewSection() {
    return Column(
      children: [
        ListHeader(title: 'Overview'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OverviewItem(title: '10,000', label: 'Revenue'),
            OverviewItem(title: '10,000', label: 'Revenue'),
            OverviewItem(title: '10,000', label: 'Revenue'),
          ],
        )
      ],
    );
  }

  _buildPopularMenuSection() {
    return Column(
      children: [
        ListHeader(title: 'Most Popular Menu'),
        Column(
          children: [
            SecondaryListItem(
              title: 'Revenue',
              rightSideChildren: [Text('258 Dishes')],
            ),
            SecondaryListItem(
              title: 'Revenue',
              rightSideChildren: [Text('258 Dishes')],
            ),
            SecondaryListItem(
              title: 'Revenue',
              rightSideChildren: [Text('258 Dishes')],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: _buildOverviewModeSelection()),
        Expanded(flex: 3, child: _buildOverviewSection()),
        Expanded(flex: 3, child: _buildPopularMenuSection()),
        Expanded(
          child: WideButton(
            title: 'View Reports',
            onPressed: () async {
              // await getTableList(context: context);
            },
          ),
        ),
      ],
    );
  }
}

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late Future<Map<String, List<Order>>> _getOrderList;

  @override
  void initState() {
    super.initState();
    _getOrderList = getOrders(context: context);
  }

  _refetch() {
    setState(() {
      _getOrderList = getOrders(context: context);
    });
  }

  _buildSubList(
      {required List<Order> list,
      required String title,
      required Color color,
      isUpdatable = false}) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Column(children: [
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: kHeaderTextStyle,
            )),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            var order = list[index];

            List<Widget> buttons = isUpdatable
                ? [
                    PrimaryButton(
                        color: kCompletedColor.withOpacity(0.5),
                        text: 'Complete',
                        onPressed: () async {
                          await completeOrder(order.id, context: context);
                          _refetch();
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.008,
                    ),
                    PrimaryButton(
                        color: kCancelledColor.withOpacity(0.5),
                        text: "Cancel",
                        onPressed: () async {
                          await cancelOrder(order.id, context: context);
                          _refetch();
                        }),
                  ]
                : [
                    Text(
                      '฿ ${order.price.toStringAsFixed(1)}',
                      style: kHeaderTextStyle,
                    ),
                  ];
            return PrimaryListItem(
                isExapandable: true,
                title: order.id,
                subTitle: 'Table: ${order.tableId}',
                rightSizeChildren: buttons,
                indicatorColor: color,
                expandedChild: OrderDetails(
                  order: order,
                ));
          },
        ),
        const Divider(
          color: kBorderColor,
          thickness: 1,
        ),
      ]),
    );
  }

  _buildOrderList() {
    return FutureBuilder(
        future: _getOrderList,
        builder: (context, AsyncSnapshot<Map<String, List<Order>>> snapshot) {
          if (snapshot.hasData) {
            Map<String, List<Order>> orderList = snapshot.data ??
                {'pending': [], 'completed': [], 'canceled': [], 'history': []};
            return SingleChildScrollView(
              child: Column(children: [
                _buildSubList(
                    list: orderList['pending'] ?? [],
                    title: 'Pending',
                    color: kInprogressColor,
                    isUpdatable: true),
                _buildSubList(
                    list: orderList['completed'] ?? [],
                    title: 'Completed',
                    color: kCompletedColor),
                _buildSubList(
                    list: orderList['canceled'] ?? [],
                    title: 'Canceled',
                    color: kCancelledColor),
                _buildSubList(
                    list: orderList['hidden'] ?? [],
                    title: 'History',
                    color: kPrimaryFontColor),
              ]),
            );
          } else {
            return const Center(child: PrimaryCircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildOrderList();
  }
}
