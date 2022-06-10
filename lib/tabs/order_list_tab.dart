import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/components/order_detail.dart';
import 'package:restaurant_table_management/components/primary_list_item.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/domains/order.dart';
import 'package:restaurant_table_management/services/services.dart';

class OrderListTab extends StatelessWidget {
  const OrderListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Expanded(child: OrderList())],
      ),
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
    _getOrderList = getOrders();
  }

  _onCompleted() {
    //ADD Api  Here
    _refetch();
  }

  _onCancelled() {
    //ADD Api Here
    _refetch();
  }

  _refetch() {
    setState(() {
      _getOrderList = getOrders();
    });
  }

  _buildSubList(
      {required List<Order> list,
      required String title,
      required Color color,
      isUpdatable = false}) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      decoration: BoxDecoration(
        border: Border.all(color: kBorderColor),
      ),
      child: Column(children: [
        Text(title),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            var order = list[index];

            List<Widget> buttons = isUpdatable
                ? [
                    PrimaryButton(
                        text: 'Complete',
                        onPressed: () {
                          completeOrder(order.id);
                        }),
                    PrimaryButton(
                        text: "Cancel",
                        onPressed: () {
                          cancelOrder(order.id);
                        }),
                  ]
                : [];
            return PrimaryListItem(
                isExapandable: true,
                title: order.id,
                subTitle: order.tableId ?? '',
                rightSizeChildren: buttons,
                indicatorColor: color,
                expandedChild: OrderDetails(
                  order: order,
                ));
          },
        )
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
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildOrderList();
  }
}
