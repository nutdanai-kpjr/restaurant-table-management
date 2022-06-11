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
import '../components/primary_circular_progress_indicator.dart';
import '../components/primary_list_item.dart';
import '../components/primary_scaffold.dart';
import '../constants.dart';
import '../domains/order.dart';
import '../domains/orderSummary.dart';
import '../services/service.dart';

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
            await confirmCheckout(tableID, context: context);
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
    _getCheckoutList = getCheckoutOrders(tableID, context: context);
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
      _getCheckoutList = getCheckoutOrders(tableID, context: context);
    });
  }

  _buildOrderList({
    required List<Order> list,
    required String title,
  }) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
      child: Column(children: [
        SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: kHeaderTextStyle,
            )),
        const Divider(
          color: kBorderColor,
          thickness: 2,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            var order = list[index];
            return PrimaryListItem(
                isExapandable: true,
                title: order.id,
                subTitle: '',
                rightSizeChildren: [
                  Text(
                    '฿ ${order.price.toString()}',
                    style: kHeaderTextStyle,
                  )
                ],
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
                  title: 'Order Summary',
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.015),
                  child: const Divider(
                    color: kPrimaryFontColor,
                    thickness: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.015,
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: kHeaderTextStyle.copyWith(
                            fontSize: kAppTitle2FontSize),
                      ),
                      Text(
                        '฿ ${totalPrice.toStringAsFixed(1)}',
                        style: kHeaderTextStyle.copyWith(
                            fontSize: kAppTitle2FontSize),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          } else {
            return const Center(child: PrimaryCircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCheckoutList();
  }
}
