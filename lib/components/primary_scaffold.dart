import 'package:flutter/material.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold(
      {Key? key,
      required this.body,
      this.appbar,
      this.bottomNavigationBar,
      this.resizeToAvoidBottomInset = false})
      : super(key: key);
  final Widget body;
  final AppBar? appbar;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
