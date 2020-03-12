import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialSuite/Core/AuthService.dart';
import 'package:socialSuite/UI/GettingStarted.dart';
import 'package:socialSuite/UI/Profile.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email, _password, _confirmPassword;

  AuthService _auth = new AuthService();

  void _callTheSignUp() async {
    if (_password == _confirmPassword) {
      return await _auth
          .registerWithEmailAndPassword(_email, _password)
          .then(
            (value) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => GettingStarted())),
          )
          .catchError((err) => print("Error: " + err));
    } else {
      return print("Not Same Password");
    }
  }

  // #Widgets
  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (val) {
              print(title + ": " + val);

              if (title == "Email") {
                setState(() => _email = val);
              } else if (title == "Password") {
                setState(() => _password = val);
              } else {
                setState(() => _confirmPassword = val);
              }
            },
            obscureText: isPassword,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: title,
                suffixIcon:
                    (title == "Email") ? Icon(Icons.email) : Icon(Icons.https)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
            child: Column(
          children: <Widget>[
            SizedBox(height: 60),
            SvgPicture.asset("assets/images/Logo.svg"),
            Container(
              width: 350,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    "SocialSuite",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get a deeper understanding about your growth and learn more about your users only with SocialSuite.",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  _entryField("Email"),
                  SizedBox(height: 65),
                  _entryField("Password", isPassword: true),
                  SizedBox(height: 65),
                  _entryField("Confirm Password", isPassword: true),
                  SizedBox(height: 65),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                          side: BorderSide(color: Color(0xFFFAAE3F))),
                      onPressed: () async {
                        _callTheSignUp();
                      },
                      color: Color(0xFFFAAE3F),
                      textColor: Colors.white,
                      child: Text("Register".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: new Text("Already have an account? Login"),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
