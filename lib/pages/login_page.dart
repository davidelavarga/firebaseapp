import 'package:firebaseapp/classes/auth_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.authFirebase, this.onSignIn}): super(key: key);
  final String title;
  final AuthFirebase authFirebase;
  final VoidCallback onSignIn;

  LoginPageState createState() => new LoginPageState();
}

enum FormType { Login, signIn }

class LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  FormType formType = FormType.Login;
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      backgroundColor: Colors.grey,
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: formLogin(),
          ),
        ),
      ),
    );
  }

  List<Widget> formLogin() {
    return [
      padded(
          child: new TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        decoration:
            new InputDecoration(
                icon: Icon(Icons.person), labelText: "Email"),
        autocorrect: false,
      )),
      padded(
        child: new TextFormField(
          controller: password,
          decoration: new InputDecoration(
              icon: Icon(Icons.lock), labelText: "Password"),
          autocorrect: false,
          obscureText: true,
        ),
      ),
      new Column(
        children: buttonWidget(),
      )
    ];
  }

  List<Widget> buttonWidget() {
    switch (formType) {
      case FormType.Login:
        return [
          styleButton('Login', validateSubmit),
          new FlatButton(
              onPressed: () => updateFormType(FormType.signIn),
              child: new Text("Do you need an account?"))
        ];
      case FormType.signIn:
        return [
          styleButton('Create', validateSubmit),
          new FlatButton(
              onPressed: () => updateFormType(FormType.Login),
              child: new Text("Login in"))
        ];
    }
  }

  void updateFormType(FormType form) {
    formKey.currentState.reset();
    setState(() {
      formType = form;
    });
  }

  void validateSubmit() {
    (formType == FormType.Login)
        ? widget.authFirebase.signIn(email.text, password.text)
        : widget.authFirebase.createUser(email.text, password.text);
    widget.onSignIn();
  }

  Widget styleButton(String text, VoidCallback onPressed) {
    return new RaisedButton(
      onPressed: onPressed,
      color: Colors.blue,
      textColor: Colors.white,
      child: new Text(text),
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
