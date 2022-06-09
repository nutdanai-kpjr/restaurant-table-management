// Rounded Corner ListItem
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

//// Have two part widget of (Title) and widget of (Action)
///  Have boolean to display input indiator on the left side.
///  If isDisplayIndicator then assert to have indicator color.
///

/// ListItem Subtype
/// Without Indicator
// 1. CheckoutItem  (Order: ID, | Price, ExpandableButton)
//    -Tap to see order and its quantity
// 2. OrderDetailItem
//      Default (MenuName | Quantity | EditButton)
//      On Edit (MenuName | -Quantity + | ConfrimButton)
// 3. MenuItem
//      Default (MenuName | AddButton)
//      On Edit (MenuName | -Quantity + | ConfrimButton)

/// With Indicator
/// 4. OrderStatusItem
///     Pending (Table Number | CompleteButton , CancelButton, ExpandableButton)
///      -Tap to see order and quantity its
///     Completed (Table Number)
///     Cancelled (Table Number)
///     History (Order Number))
class SecondaryListItem extends StatelessWidget {
  const SecondaryListItem({
    Key? key,
    required this.title,
    required this.buttons,
  }) : super(key: key);
  final String title;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
        height: MediaQuery.of(context).size.height * 0.075,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(title),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  children: buttons,
                )),
          ],
        ));
  }
}
