import 'package:MiniPocket_flutter/activities/main/new_transfer.dart';
import 'package:MiniPocket_flutter/components/custom_text_field.dart';
import 'package:MiniPocket_flutter/main/constat.dart';
import 'package:MiniPocket_flutter/models/UserAuthentication.dart';
import 'package:MiniPocket_flutter/models/CurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FragmentAuthentication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FragmentAuthentication();
  }
}

class _FragmentAuthentication extends State<FragmentAuthentication> {
  String email = "", password = "", errorMessage = "";

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: GRAY,
      elevation: 5,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          "Log in",
          style: TextStyle(
            fontFamily: 'math_tapping',
            color: YELLOW,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  Widget getSignInPage(Size screenSize) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            "assets/icon_none.png",
            width: screenSize.height * 0.2,
            height: screenSize.height * 0.2,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: CustomTextField(
              child: TextFormField(
                initialValue: email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: WHITE,
                  fontFamily: 'chalkboard',
                  fontSize: 17,
                  decorationColor: BLUE,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: BLUE,
                    fontFamily: 'math_tapping',
                    fontSize: 17,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: BLUE,
                    fontFamily: 'math_tapping',
                    fontSize: 17,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  email = text;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: CustomTextField(
              child: TextFormField(
                initialValue: password,
                style: TextStyle(
                  color: WHITE,
                  fontFamily: 'chalkboard',
                  fontSize: 17,
                  decorationColor: BLUE,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: BLUE,
//                  fontFamily: 'math_tapping',
                    fontSize: 17,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: BLUE,
                    fontFamily: 'math_tapping',
                    fontSize: 17,
                  ),
                  border: InputBorder.none,
                ),
                obscureText: true,
                onChanged: (text) {
                  password = text;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              ((errorMessage != "") ? "*" : "") + errorMessage,
              style:
                  TextStyle(color: RED, fontFamily: "chalkboard", fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: BLUE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 10, bottom: 10),
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'math_tapping',
                    color: GRAY,
                  ),
                ),
              ),
              onPressed: () async {
                print("clicked");

                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                } catch (e) {
                  print(e);
                  print("123");
                  setState(() {
                    errorMessage = e.message;
                  });
                }
              },
            ),
          ),
          Row(
            children: [
              Spacer(),
              FlatButton(
                child: Image.asset(
                  "assets/icon_facebook.png",
                  width: screenSize.height * 0.05,
                  height: screenSize.height * 0.05,
                ),
                onPressed: () async {
                  print("clicked Facebook");
                  await UserAuthentication.signInWithFacebook(context);
                },
              ),
              Text(
                "or",
                style: TextStyle(color: WHITE, fontFamily: 'chalkboard'),
              ),
              FlatButton(
                child: Image.asset(
                  "assets/icon_google.png",
                  width: screenSize.height * 0.05,
                  height: screenSize.height * 0.05,
                ),
                onPressed: () async {
                  print("clicked Google");
                  try {
                    await UserAuthentication.signInWithGoogle();
                  } on PlatformException catch (e) {
//                    print(e.code);
                  }
                },
              ),
              Spacer(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              top: 20,
            ),
            child: Row(
              children: [
                Spacer(),
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: WHITE,
                    fontFamily: "chalkboard",
                    fontSize: 14,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: BLUE,
                      fontSize: 14,
                      fontFamily: 'chalkboard',
                    ),
                  ),
                  onPressed: () {
                    print("Clicked sign up button");
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: GRAY,
        appBar: buildAppBar(),
        body:SingleChildScrollView(child: getSignInPage(screenSize)),
        // StreamBuilder<FirebaseUser>(
        //     stream: FirebaseAuth.instance.onAuthStateChanged,
        //     builder: (context, snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.waiting:
        //           return Center(
        //               child: CircularProgressIndicator(
        //             valueColor: AlwaysStoppedAnimation<Color>(BLUE),
        //           ));
        //           break;
        //
        //         case ConnectionState.active:
        //           if (snapshot.data != null) {
        //             return Column(
        //               children: [
        //                 Text(
        //                   "Signed in " + snapshot.data.uid,
        //                   style: TextStyle(
        //                     color: WHITE,
        //                     fontSize: 25,
        //                   ),
        //                 ),
        //                 RaisedButton(
        //                     child: Text("Sign out"),
        //                     onPressed: () {
        //                       FirebaseAuth.instance.signOut();
        //                     }),
        //               ],
        //             );
        //           } else {
        //             return getSignInPage(screenSize);
        //           }
        //           break;
        //
        //         default:
        //           print("Default");
        //           return Center(
        //             child: Text(
        //               "something goes wrong!",
        //               style: TextStyle(
        //                   color: BLUE, fontSize: 20, fontFamily: "chalkboard"),
        //             ),
        //           );
        //       }
        //     })
        );
  }
}
