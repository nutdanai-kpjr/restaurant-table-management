import 'package:flutter/material.dart';

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

  Widget _buildOrderDetail() {
    var menuNameandQuantityandPrice = getMenuNameandQuantityandPrice();
    return Column(children: [
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
              ),
              Text('Price: ฿${menu.value['price']}'),
            ],
          ),
        ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildOrderDetail();
  }
}
