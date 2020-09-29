import 'package:MiniPocket_flutter/components/app_bar.dart';
import 'package:MiniPocket_flutter/main/constat.dart';
import 'package:MiniPocket_flutter/models/CurrentUser.dart';
import 'package:MiniPocket_flutter/models/transferdetails/WeeklyDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FragmentStatus extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FragmentStatusState();
  }
}

class _FragmentStatusState extends State<FragmentStatus> {
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,##0", "en_US");
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: GRAY,
        appBar: buildAppBar("Current status"),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StreamBuilder(
                stream: Firestore.instance.collection(CurrentUser.uid).document(DETAIL_USER).snapshots(),
                builder: (context, snapshot){
                  var text;
                  if (snapshot.hasData) text = formatter.format(snapshot.data['my_money']); else text = "...";
                  return Text(
                    text,
                    style: TextStyle(
                      color: YELLOW,
                      fontSize: 25,
                      fontFamily: 'math_tapping',
                    ),
                  );
                },
              ),
              FlatButton(
                onPressed: () async{
                  print("pressed");
                  WeeklyDetail.updateTransactionFromFirebase();
                },
                child: Container(
                  width: screenSize.height * 0.3,
                  height: screenSize.height * 0.3,
                  decoration: BoxDecoration(
                      color: YELLOW,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: YELLOW_DARK,
                            offset: Offset(0, 5),
                            blurRadius: 0
                        )
                      ]
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

}
