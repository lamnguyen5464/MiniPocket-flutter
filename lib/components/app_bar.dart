
import 'package:flutter/material.dart';

import '../main/constat.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: GRAY,
    elevation: 5,
    centerTitle: false,
    title: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'math_tapping',
          color: YELLOW,
          fontSize: 25,
        ),
      ),
    ),
  );
}