
import 'package:flutter/cupertino.dart';

import '../constat.dart';

class CusTomToggleButton extends StatelessWidget{

  bool _isToggled;
  String _text;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.width*0.2,
      width: screenSize.width*0.2,
      decoration: (_isToggled) ? BoxDecoration(
        color: GRAY,
        borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: BLACK, offset: Offset(0, 0.2), blurRadius: 0)
          ]
      ) : decorated3DBlack,
      child: Center(
        child: Text(
          this._text,
          textAlign: TextAlign.center,
          style: TextStyle(color: WHITE, fontFamily: 'chalkboard', fontSize: 12,),
        ),
      ),

    );
  }
  CusTomToggleButton(this._isToggled, this._text);

}