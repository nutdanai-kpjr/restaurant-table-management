import 'package:flutter/material.dart';
import 'package:restaurant_table_management/constants.dart';

class WideButton extends StatelessWidget {
  const WideButton({Key? key, required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.075,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary: kThemeFontColor,
              backgroundColor: kThemeColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
              textStyle:
                  kAppTitleTextStyle.copyWith(fontSize: kHeaderFontSize)),
          onPressed: onPressed,
          child: Text(title)),
    );
  }
}
