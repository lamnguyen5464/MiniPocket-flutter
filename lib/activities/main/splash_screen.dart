
import 'package:MiniPocket_flutter/main/constat.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 2000), (){
      Navigator.pushNamed(context, '/main_activity');
    });
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: GRAY,
      child: Image.asset(
        "assets/icon_none.png",
        width: screenSize.height * 1,
        height: screenSize.height * 1,
      ),
    );
  }
}
