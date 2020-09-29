import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import '../main/constat.dart';

class UserAuthentication {
  Future<FirebaseUser> signIn() async {
    try {
      AuthResult result = await FirebaseAuth.instance.signInAnonymously();
      return result.user;
    } catch (e) {
      print("Error:______________");
      print(e);
      return null;
    }
  }

  static Future<AuthResult> signInWithGoogle() async {

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if(googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    if (googleAuth != null){

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);

    }

    return null;

  }
  static Future linkFacebookToGoogle(AuthCredential credentialFacebook, FacebookLoginResult result) async{
        final httpClient = new HttpClient();
        final graphRequest = await httpClient.getUrl(Uri.parse("https://graph.facebook.com/v2.12/me?fields=email&access_token=${result.accessToken.token}"));
        final graphResponse = await graphRequest.close();
        final graphResponseJSON = json.decode((await graphResponse.transform(utf8.decoder).single));
        final email = graphResponseJSON["email"];
        print(email + "*******");
        final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: email);

        if (signInMethods[0] == "google.com"){
          final authResult = await signInWithGoogle();
          if (authResult.user.email == email) {
            // Now we can link the accounts together
            await authResult.user.linkWithCredential(credentialFacebook);
          }

        }


  }
  static Future<AuthResult> signInWithFacebook(BuildContext context) async{
    final resultLoginFacebook = await FacebookLogin().logIn(["email"]);

    if (resultLoginFacebook.status == FacebookLoginStatus.loggedIn) {
      final credentialFacebook = FacebookAuthProvider.getCredential(
          accessToken: resultLoginFacebook.accessToken.token);
      try{

        return await FirebaseAuth.instance.signInWithCredential(credentialFacebook);

      }on PlatformException catch(e){
        if (e.code != 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')
          throw e;
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(
                'Alert!',
                style: TextStyle(
                    color: WHITE, fontFamily: 'chalkboard'),
              ),
              backgroundColor: GRAY,
              content: Text(
                'This email has been used to sign up by Google.',
                style: TextStyle(
                    color: WHITE_DARK, fontFamily: 'chalkboard'),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Oh okay',
                    style: TextStyle(
                        color: WHITE, fontFamily: 'chalkboard'),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext)
                        .pop(); // Dismiss alert dialog
                  },
                ),
                FlatButton(
                  child: Text(
                    'Link to Google',
                    style: TextStyle(
                        color: WHITE, fontFamily: 'chalkboard'),
                  ),
                  onPressed: () async {
                    await linkFacebookToGoogle(credentialFacebook, resultLoginFacebook);
                    Navigator.of(dialogContext)
                        .pop();
                  },
                )
              ],
            );
          },
        );
      }

    }
    return null;
  }

}
