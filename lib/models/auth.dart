import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import '../Data/data.dart';
import 'package:provider/provider.dart';

enum loginMethod {
  Google,
  Facebook
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FacebookLogin _facebookLogin = FacebookLogin();
loginMethod method;
bool loggedin = false;

Future<bool> signInWithGoogle(context) async {
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
  return loggedin;
}

Future<void> signOutGoogle() async {
  await _googleSignIn.signOut();
}

Future<bool> signInWithFacebook(context) async {
  
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
  return loggedin;
}
  Future<void> signOutFacebook() async {
  await _facebookLogin.logOut();
}

void signOut() {
  switch(method){
    case loginMethod.Google: signOutGoogle(); break;
    case loginMethod.Facebook: signOutGoogle(); break;
  }
}


