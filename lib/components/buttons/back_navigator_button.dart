import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

class BackNavigatorButton extends StatelessWidget {
  const BackNavigatorButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackButton(
          color: kPrimaryFontColor,
          onPressed: onPressed,
        ),
        InkWell(
          onTap: onPressed,
          child: const Text(
            'Back',
            style: kPrimaryTextStyle,
          ),
        )
      ],
    );
  }
}
