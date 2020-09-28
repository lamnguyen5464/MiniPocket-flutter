import 'package:MiniPocket_flutter/activities/fragments/fragment_authentication.dart';
import 'package:MiniPocket_flutter/activities/fragments/fragment_status.dart';
import 'package:MiniPocket_flutter/activities/fragments/fragment_transfer.dart';
import 'package:MiniPocket_flutter/components/app_bar.dart';
import 'package:MiniPocket_flutter/constat.dart';
import 'package:MiniPocket_flutter/models/CurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainActivityState();
  }
}

class _MainActivityState extends State<MainActivity> {
  int currentSelection = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //Force to authenticate before joining
          CurrentUser.uid = snapshot.data.uid;
          return Scaffold(
            backgroundColor: GRAY,
            body: getBody(currentSelection),
            bottomNavigationBar: buildBottomNavigationBar(),
          );
        } else {
          return FragmentAuthentication();
        }
      },
    );
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return FragmentTransfer();
      case 1:
        return FragmentStatus();
      case 2:
        return Scaffold(
          appBar: buildAppBar("Account"),
          backgroundColor: GRAY,
          body: Column(
            children: [
              Text(
                "Signed in " + CurrentUser.uid,
                style: TextStyle(
                  color: WHITE,
                  fontSize: 25,
                ),
              ),
              RaisedButton(
                  child: Text("Sign out"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ],
          ),
        );
      default:
        return Text("tmp");
    }
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          currentSelection = index;
        });
      },
      backgroundColor: GRAY,
      currentIndex: currentSelection,
      selectedIconTheme: IconThemeData(
        color: WHITE,
      ),
      items: [
        BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("assets/icon_transfer.png"),
              width: 25,
              height: 25,
              color: (currentSelection == 0) ? YELLOW : BLACK,
            ),
            title: Text("")),
        BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("assets/icon_status.png"),
              width: 25,
              height: 25,
              color: (currentSelection == 1) ? YELLOW : BLACK,
            ),
            title: Text("")),
        BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("assets/icon_cloud.png"),
              width: 25,
              height: 25,
              color: (currentSelection == 2) ? YELLOW : BLACK,
            ),
            title: Text("")),
      ],
    );
  }
}
