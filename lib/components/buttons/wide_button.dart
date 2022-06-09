import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({Key? key, required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Text(title));
  }
}
