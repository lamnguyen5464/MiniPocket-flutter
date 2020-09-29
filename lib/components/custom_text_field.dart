

import 'package:flutter/material.dart';

import '../main/styles.dart';

class CustomTextField extends StatelessWidget {
  final Widget child;

  const CustomTextField({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: decorated3DBlack,
      child: child,
    );
  }
}
