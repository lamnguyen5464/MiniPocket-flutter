
import 'package:flutter/cupertino.dart';

import '../constat.dart';
import '../styles.dart';

class CusTomToggleButtonWeekDay extends StatelessWidget{

  bool _isToggled;
  String _text;
  Color _currentColor;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.width*0.1,
      width: screenSize.width*0.1,
      decoration: BoxDecoration(
        color: (_isToggled) ? _currentColor : GRAY,
        borderRadius: BorderRadius.circular(100),
//        border: Border.all(color: GRAY, width: 2),
      ),
      child: Center(
        child: Text(
          this._text,
          textAlign: TextAlign.center,
          style: TextStyle(color: WHITE, fontFamily: 'chalkboard', fontSize: 15,),
        ),
      ),

    );
  }

  CusTomToggleButtonWeekDay(this._isToggled, this._text, this._currentColor);
}