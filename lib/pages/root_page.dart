import 'package:firebaseapp/classes/auth_firebase.dart';
import 'package:firebaseapp/pages/home_page.dart';
import 'package:firebaseapp/pages/login_page.dart';
import 'package:flutter/cupertino.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.authFirebase}) : super(key: key);
  final AuthFirebase authFirebase;
  @override
  State<StatefulWidget> createState() => new RootPageState();
}

enum AuthStatus {
  notSingedIn,
  singedIn,
}

class RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSingedIn;
  @override
  void initState() {
    widget.authFirebase.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId != null ? AuthStatus.singedIn : AuthStatus.notSingedIn;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSingedIn:
        return new LoginPage(
            title: "Login",
            authFirebase: widget.authFirebase,
            onSignIn: () => updateAuthStatus(AuthStatus.singedIn));
      case AuthStatus.singedIn:
        return new HomePage(
            onSignIn: () => updateAuthStatus(AuthStatus.notSingedIn),
            authFirebase: widget.authFirebase);
    }
  }

  void updateAuthStatus(AuthStatus auth) {
    setState(() {
      authStatus = auth;
    });
  }
}
