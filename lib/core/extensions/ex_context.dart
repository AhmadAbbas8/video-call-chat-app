import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  push(Widget page) async => await Navigator.push(
        this,
        MaterialPageRoute(builder: (context) => page),
      );

  pushReplacement(Widget page) async => await Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => page),
      );

  pushAndRemoveUntil(Widget page) async => await Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );

  pop() => Navigator.pop(this);

  popUntil(String routeName) =>
      Navigator.popUntil(this, ModalRoute.withName(routeName));

  showSnackBar(SnackBar snackBar) =>
      ScaffoldMessenger.of(this).showSnackBar(snackBar);

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get canPop => Navigator.canPop(this);
}
