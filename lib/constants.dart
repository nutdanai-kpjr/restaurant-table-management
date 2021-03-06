import 'package:flutter/material.dart';

const Color kThemeColor = Color(0xFF41669E);
const Color kThemeFontColor = Color(0xFFFFFFFF);
const Color kInprogressColor = Color(0XFFFFC245);
const Color kCompletedColor = Color(0XFF0CC265);
const Color kCancelledColor = Color(0XFFFF5454);
const Color kFocusFontColor = Color(0XFF393939);
const Color kPrimaryFontColor = Color(0XFF737373);
const Color kSecondaryFontColor = Color(0XFFA8A8A8);
const Color kBorderColor = Color(0XFFECECEC);

const double kAppTitleFontSize = 28.0;
const double kAppTitle2FontSize = 20.0;
const double kHeaderFontSize = 16.0;
const double kPrimaryFontSize = 14.0;
const double kSecondaryFontSize = 12.0;

const TextStyle kAppTitleTextStyle = TextStyle(
  fontSize: kAppTitleFontSize,
  fontWeight: FontWeight.bold,
  color: kThemeFontColor,
);
const TextStyle kPrimaryTextStyle = TextStyle(
  fontSize: kPrimaryFontSize,
  fontWeight: FontWeight.w500,
  color: kPrimaryFontColor,
);

const TextStyle kHeaderTextStyle = TextStyle(
  fontSize: kHeaderFontSize,
  fontWeight: FontWeight.bold,
  color: kPrimaryFontColor,
);

const TextStyle kSecondaryTextStyle = TextStyle(
  fontSize: kSecondaryFontSize,
  color: kSecondaryFontColor,
);

InputDecoration kTextFieldDecorationWithHintText(String hintText) =>
    InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: kThemeColor.withOpacity(0.5), width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: kBorderColor, width: 2.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          // fontSize: kListItemSubTitleFontSize,
          color: kSecondaryFontColor,
        ));

double kWidth(context) => MediaQuery.of(context).size.width;
double kHeight(context) => MediaQuery.of(context).size.height;
