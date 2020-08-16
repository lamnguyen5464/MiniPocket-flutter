import 'package:flutter/material.dart';

const BLACK = Color(0xff000000);
const GRAY = Color(0xff2F2F2F);
const GRAY_LIGHT = Color(0xff3A3B3D);
const WHITE = Color(0xffffffff);
const WHITE_DARK = Color(0xff797979);
const BLUE = Color(0xff87a6f5);
const BLUE_DARK = Color(0xff87a6f0);
const GREEN = Color(0xff91de7a);
const GREEN_DARK = Color(0xff3B7822);
const YELLOW = Color(0xffffe570);
const YELLOW_DARK = Color(0xff7B6F37);
const RED = Color(0xffFF7676);
const RED_DARK = Color(0xffC02C37);
const COLLECTION_TAG = "NonRepeatedDetails";
const ERROR_WRONG_PASSWORD_TAG = "";

var decorated3DBlack = BoxDecoration(
    color: GRAY,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(color: BLACK, offset: Offset(0, 1), blurRadius: 0)
    ])
;