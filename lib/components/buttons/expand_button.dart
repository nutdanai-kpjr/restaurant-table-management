import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onPressed, icon: const Icon(Icons.expand_more)),
      ],
    );
  }
}
