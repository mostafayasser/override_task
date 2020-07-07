import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../Data/data.dart';
import '../helpers/routes.dart';

enum loginMethod {
  Google,
  Facebook
}




loginMethod method;
bool loggedin = false;

Future<void> getUserPrefs(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString("id");
  if(userID == null){
    Navigator.of(context).pushReplacementNamed(signInScreenRoute);
  } else{
    if(userID.endsWith(".com")){
      method = loginMethod.Google;
    } else{
      method = loginMethod.Facebook;
    }
    Provider.of<Data>(context, listen: false).getData(email: userID);
    Navigator.of(context).pushReplacementNamed(todoListScreenRoute);
  }
}

Future<void> setUserPrefs(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id", id);
}

Future<bool> signInWithGoogle(context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email;

  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  if(googleUser == null){
    return loggedin;
  }
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // get the credentials to (access / id token)
  // to sign in via Firebase Authentication
  final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  email = (await _auth.signInWithCredential(credential)).user.email;
  if(email != null){
  loggedin = true;
  method = loginMethod.Google;
  Provider.of<Data>(context, listen: false).getData(email: email);
  }
  setUserPrefs(email);
  return loggedin;
}

Future<void> signOutGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signOut();
   
}

Future<bool> signInWithFacebook(context) async {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final result = await _facebookLogin.logIn(['email']);

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
    loggedin = true;
    method = loginMethod.Facebook;
      Provider.of<Data>(context, listen: false)
          .getData(email: result.accessToken.userId);
      break;
    case FacebookLoginStatus.cancelledByUser:
      break;
      case FacebookLoginStatus.error:
    break;
    
  }
  setUserPrefs(result.accessToken.userId);
  return loggedin;
}
  Future<void> signOutFacebook() async {
    final FacebookLogin _facebookLogin = FacebookLogin();
  await _facebookLogin.logOut();
  
}

void signOut() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove("id");
  switch(method){
    case loginMethod.Google: signOutGoogle(); break;
    case loginMethod.Facebook: signOutFacebook(); break;
  }
}


