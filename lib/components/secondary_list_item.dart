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
    required this.rightSideChildren,
    this.isDisabled = false,
  }) : super(key: key);
  final String title;
  final List<Widget> rightSideChildren;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0025),
        height: MediaQuery.of(context).size.height * 0.075,
        decoration: BoxDecoration(
          border: Border.all(
              color: !isDisabled ? kBorderColor : kBorderColor.withOpacity(0.5),
              width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.015),
                child: Text(
                  title,
                  style: !isDisabled
                      ? kHeaderTextStyle
                      : kHeaderTextStyle.copyWith(
                          color: kPrimaryFontColor.withOpacity(0.5)),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: !isDisabled ? rightSideChildren : [],
                  ),
                )),
          ],
        ));
  }
}
