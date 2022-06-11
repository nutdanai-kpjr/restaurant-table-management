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
class PrimaryListItem extends StatefulWidget {
  const PrimaryListItem(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.rightSizeChildren,
      required this.indicatorColor,
      this.isExapandable = false,
      this.expandedChild})
      : super(key: key);
  final String subTitle;
  final String title;
  final List<Widget> rightSizeChildren;
  final Color indicatorColor;
  final bool isExapandable;
  final Widget? expandedChild;

  @override
  State<PrimaryListItem> createState() => _PrimaryListItemState();
}

class _PrimaryListItemState extends State<PrimaryListItem> {
  bool _isExpanded = false;
  Widget _buildExpandButton() {
    return Row(children: [
      IconButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          icon: Icon(!_isExpanded ? Icons.expand_more : Icons.expand_less)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var newButtons = !widget.isExapandable
        ? widget.rightSizeChildren
        : [...widget.rightSizeChildren, _buildExpandButton()];
    return LimitedBox(
      maxHeight: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                border: Border.all(color: kBorderColor, width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widget.indicatorColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(14.5),
                                    bottomLeft: Radius.circular(14.5),
                                  )),
                            )),
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.0125),
                                  width: double.infinity,
                                  child: Text(widget.title,
                                      style: kPrimaryTextStyle.copyWith(
                                          fontSize: kHeaderFontSize))),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.0125),
                                  width: double.infinity,
                                  child: Text(widget.subTitle,
                                      style: kSecondaryTextStyle)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: newButtons),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          widget.isExapandable && _isExpanded
              ? widget.expandedChild ?? Container()
              : Container(),
        ],
      ),
    );
  }
}
