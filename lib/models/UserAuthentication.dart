import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;


    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);

  }
  static Future signInWithFacebook() async{
    final result = await FacebookLogin().logIn(["email"]);

    print(result.status);

    if (result.status == FacebookLoginStatus.loggedIn){
      final credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);

      try{
        final FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print("signed in " + user.displayName);
      }on PlatformException catch(e){
        if (e.code != 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')
          throw e;
        // Now we caught the error we're talking about, we get the email by calling graph API manually
        final httpClient = new HttpClient();
        final graphRequest = await httpClient.getUrl(Uri.parse("https://graph.facebook.com/v2.12/me?fields=email&access_token=${result.accessToken.token}"));
        final graphResponse = await graphRequest.close();
        final graphResponseJSON = json.decode((await graphResponse.transform(utf8.decoder).single));
        final email = graphResponseJSON["email"];
        print(email + "*******");
        // Now we have both credential and email that is required for linking
        final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: email);
        // Assume that signInMethods[0] is 'google.com'



        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential1 = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final authResult = await signInWithGoogle();  // ... do the Google sign-in logic here and get the Firebase AuthResult
    if (authResult.user.email == email) {
    // Now we can link the accounts together
    await authResult.user.linkWithCredential(credential);
    }

  }
    }
  }
//  static void signInWithEmailPassword(String email, String password){
//
//  }
}
