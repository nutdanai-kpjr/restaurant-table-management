// OutlinedButton
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/quantity_selector.dart';

//// Fix Round/Fontcolor/FontSize
///  Customizable BorderColor and Button Size
///

// PrimaryButton Subtype
// - Default (Check In , Check Out , Ok) - kBorderColor
// - Confrim,Add -kComplete
// - Pending,Edit - kInprogress
// - Cancel - kCancel
//   Expanable button - kPrimary

// ButtonSets
// 1. MenuButtonSet
//    -Add (Add Button)
//    -EditMode ( QuantitySelector, Confirm Button)
//    -Edit (Quantity, Edit Button)

// 2. OrderButtonSet
//    -Pending (Complete Button , Cancel Button, Expandalbe Button)
//

/// 3. CheckoutSet
///   -ExpandButton
///

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.text, this.onPressed})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Text(text));
  }
}

class MenuButton extends StatefulWidget {
  const MenuButton({Key? key, this.onQuantityChanged}) : super(key: key);
  final Function(int)? onQuantityChanged;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  int quantity = 0;
  bool isEditing = false;
  late final Function(int)? onQuantityChanged = widget.onQuantityChanged;

  _turnOnEditMode() {
    setState(() {
      isEditing = true;
    });
  }

  _onQuantityChanged(int n) {
    setState(() {
      quantity = n;

      onQuantityChanged?.call(n);
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quantity == 0 && !isEditing) {
      return PrimaryButton(
        text: 'Add',
        onPressed: _turnOnEditMode,
      );
    } else if (isEditing) {
      return Row(
        children: [
          QuantitySelectorButton(
            onConfrimQuantity: _onQuantityChanged,
            quantity: quantity,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Text(quantity.toString()),
          PrimaryButton(
            text: 'Edit',
            onPressed: _turnOnEditMode,
          )
        ],
      );
    }
  }
}
