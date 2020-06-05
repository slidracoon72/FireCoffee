import 'package:firecoffee/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firecoffee/shared/constants.dart';
import 'package:firecoffee/shared/loading.dart';
import 'package:firecoffee/screens/authenticate/verticalText.dart';
import 'package:firecoffee/screens/authenticate/textLogin.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                'Fire🔥Coffee',
                style: TextStyle(color: Colors.brown[400]),
              ),
              centerTitle: true,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.brown[400],
                  ),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.brown[400]),
                  ),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.brown[200], Colors.brown[900]]),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      VerticalText(),
                      TextLogin(),
                    ]),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: "Email",
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          )),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: "Password",
                          icon: Icon(Icons.security, color: Colors.white)),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                        color: Colors.white,
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(color: Colors.brown),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those credentials';
                                loading = false;
                              });
                            }
                          }
                        }),
                    SizedBox(height: 9.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.redAccent, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
