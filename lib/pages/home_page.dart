import 'package:firebaseapp/classes/auth_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({this.onSignIn, this.authFirebase});
  final VoidCallback onSignIn;
  final AuthFirebase authFirebase;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
      actions: <Widget>[
        new FlatButton(onPressed: signOut, child: new Text("Sign Out"))
      ],
      title: new Text("Home"),
    ));
  }

  void signOut(){
    authFirebase.signOut();
    onSignIn();
  }

}
