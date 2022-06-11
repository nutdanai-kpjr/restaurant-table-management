// Row of + button , Number ,- button

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/constants.dart';

class QuantitySelectorButton extends StatefulWidget {
  const QuantitySelectorButton(
      {Key? key, required this.onConfrimQuantity, this.quantity = 0})
      : super(key: key);
  final Function(int)? onConfrimQuantity;
  final int quantity;
  @override
  State<QuantitySelectorButton> createState() => _QuantitySelectorButtonState();
}

class _QuantitySelectorButtonState extends State<QuantitySelectorButton> {
  late int quantity = widget.quantity;
  late final Function(int)? onConfirmQuantity = widget.onConfrimQuantity;

  _add() {
    setState(() {
      quantity++;
    });
  }

  _remove() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  _confirm() {
    onConfirmQuantity?.call(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          onPressed: _remove,
          icon: const Icon(
            Icons.remove,
            color: kPrimaryFontColor,
            size: kPrimaryFontSize,
          )),
      Text(
        quantity.toString(),
        style: kPrimaryTextStyle,
      ),
      IconButton(
          onPressed: _add,
          icon: const Icon(
            Icons.add,
            color: kPrimaryFontColor,
            size: kPrimaryFontSize,
          )),
      PrimaryButton(
          color: kCompletedColor.withOpacity(0.5),
          text: 'Confirm',
          onPressed: _confirm),
    ]);
  }
}
