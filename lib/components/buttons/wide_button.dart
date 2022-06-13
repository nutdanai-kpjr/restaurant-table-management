import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.backgroundColor = kThemeColor,
    this.textStyle,
    this.fontColor,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.075,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary: fontColor ?? kThemeFontColor,
              backgroundColor: backgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
              textStyle: textStyle ??
                  kAppTitleTextStyle.copyWith(fontSize: kHeaderFontSize)),
          onPressed: onPressed,
          child: Text(title)),
    );
  }
}
