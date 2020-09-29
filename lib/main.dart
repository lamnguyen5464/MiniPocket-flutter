import 'package:MiniPocket_flutter/activities/main/first_activity.dart';
import 'package:MiniPocket_flutter/activities/main/new_transfer.dart';
import 'package:flutter/material.dart';
import 'main/constat.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'math_tapping',
        textTheme: Theme.of(context).textTheme.apply(bodyColor: GRAY),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainActivity(),
      routes: <String, WidgetBuilder>{
        '/new_tranfer_activity' : (BuildContext context) => NewTransferActivity(),
      },
    );
  }
}
