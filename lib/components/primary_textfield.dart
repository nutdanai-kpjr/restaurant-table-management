import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_table_management/constants.dart';

class PrimaryTextfield extends StatelessWidget {
  const PrimaryTextfield({
    Key? key,
    required this.title,
    this.controller,
    this.padding = const EdgeInsets.all(8.0),
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
  }) : super(key: key);
  final String title;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: TextField(
          obscureText: obscureText,
          onChanged: onChanged,
          controller: controller,
          style: kPrimaryTextStyle,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: kTextFieldDecorationWithHintText(title),
        ));
  }
}
