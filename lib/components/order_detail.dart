import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

import '../domains/order.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.order}) : super(key: key);
  final Order order;

  Map<String, dynamic> getMenuNameandQuantityandPrice() {
    Map<String, dynamic> menuNameandQuantityandPrice = {};
    for (var menu in order.menuList) {
      if (menuNameandQuantityandPrice[menu.name] == null) {
        menuNameandQuantityandPrice[menu.name] = {
          'quantity': 1,
          'price': menu.price
        };
      } else {
        menuNameandQuantityandPrice[menu.name]['quantity'] += 1;
        menuNameandQuantityandPrice[menu.name]['price'] =
            menu.price * menuNameandQuantityandPrice[menu.name]['quantity'];
      }
    }
    return menuNameandQuantityandPrice;
  }

  Widget _buildOrderDetail(context) {
    var menuNameandQuantityandPrice = getMenuNameandQuantityandPrice();
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.04),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.04,
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(children: [
          ..._buildEachmenu(menuNameandQuantityandPrice),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: kHeaderTextStyle,
                ),
                Text(
                  '฿ ${order.price.toStringAsFixed(1)}',
                  style: kHeaderTextStyle,
                ),
              ],
            ),
          ),
        ]));
  }

  List<Widget> _buildEachmenu(
      Map<String, dynamic> menuNameandQuantityandPrice) {
    return [
      for (var menu in menuNameandQuantityandPrice.entries)
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${menu.key} x ${menu.value['quantity']}',
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: kPrimaryTextStyle.copyWith(fontSize: kPrimaryFontSize),
              ),
              Text(
                '฿ ${menu.value['price']}',
                style: kPrimaryTextStyle,
              ),
            ],
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return _buildOrderDetail(context);
  }
}
