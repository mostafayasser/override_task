import 'package:flutter/material.dart';

import '../helpers/routes.dart';
import '../models/auth.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton.icon(
              padding: EdgeInsets.only(left: 0, right: 20),
              onPressed: () => {
                signInWithGoogle(context).then((value) {
                  if(value){

                  Navigator.of(context)
                      .pushReplacementNamed(todoListScreenRoute);
                  }
                })
              },
              icon: Image.asset(
                "assets/images/google.jpeg",
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              label: Text("Sign in with Google"),
            ),
            RaisedButton.icon(
              padding: EdgeInsets.only(left: 0, right: 5),
              onPressed: () => {
                signInWithFacebook(context).then((value) {
                  if(value){

                  Navigator.of(context)
                      .pushReplacementNamed(todoListScreenRoute);
                  }
                })
              },
              icon: Image.asset(
                "assets/images/facebook.jpeg",
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              label: Text("Sign in with Facebook"),
            ),
          ],
        ),
      ),
    );
  }
}
