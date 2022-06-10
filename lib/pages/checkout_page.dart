// Table Header
// List of Checkout Summary
// Divider
// Total
// Wide Button: Checkout

import 'package:flutter/material.dart';
import 'package:restaurant_table_management/pages/main_page.dart';

import '../components/buttons/wide_button.dart';
import '../components/headers/Secondary_header.dart';
import '../components/order_detail.dart';
import '../components/primary_list_item.dart';
import '../components/primary_scaffold.dart';
import '../constants.dart';
import '../domains/order.dart';
import '../domains/orderSummary.dart';
import '../services/services.dart';

/// Use getCheckoutLists from TabeleProvider

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
          onPressed: () async {
            await confirmCheckout(tableID);
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
          CheckoutList(tableID: tableID),
        ]));
  }
}

class CheckoutList extends StatefulWidget {
  const CheckoutList({Key? key, required this.tableID}) : super(key: key);
  final String tableID;
  @override
  State<CheckoutList> createState() => _CheckoutListState();
}

class _CheckoutListState extends State<CheckoutList> {
  late Future<OrderSummary> _getCheckoutList;
  late final tableID = widget.tableID;
  @override
  void initState() {
    super.initState();
    _getCheckoutList = getCheckoutOrders(tableID);
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
      _getCheckoutList = getCheckoutOrders(tableID);
    });
  }

  _buildOrderList({
    required List<Order> list,
    required String title,
  }) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
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
            return PrimaryListItem(
                isExapandable: true,
                title: order.id,
                subTitle: '',
                rightSizeChildren: [Text('฿${order.price.toString()}')],
                indicatorColor: kCompletedColor,
                expandedChild: OrderDetails(
                  order: order,
                ));
          },
        )
      ]),
    );
  }

  _buildCheckoutList() {
    return FutureBuilder(
        future: _getCheckoutList,
        builder: (context, AsyncSnapshot<OrderSummary> snapshot) {
          if (snapshot.hasData) {
            List<Order> checkoutOrderList = snapshot.data?.orderList ?? [];
            double totalPrice = snapshot.data?.totalPrice ?? 0;
            return SingleChildScrollView(
              child: Column(children: [
                _buildOrderList(
                  list: checkoutOrderList,
                  title: 'Checkout Summary',
                ),
                Text(totalPrice.toString()),
              ]),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCheckoutList();
  }
}
