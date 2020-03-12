import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialSuite/Core/AuthService.dart';
import 'package:socialSuite/UI/Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;
  AuthService _auth = new AuthService();

  // #Widgets
  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (val) {
              (title == "Email")
                  ? setState(() => _email = val)
                  : setState(() => _password = val);
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
      backgroundColor: Color(0xFFFAAE3F),
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 96),
            Container(
              width: 414,
              height: 800,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 3.0,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0) //         <--- border radius here
                    ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  SvgPicture.asset('assets/images/Logo.svg'),
                  SizedBox(height: 10),
                  Text(
                    "SocialSuite",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "SocialMedia Data Tracker for creators",
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 350,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50),
                        _entryField("Email"),
                        SizedBox(height: 50),
                        _entryField("Password", isPassword: true),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  Container(
                    width: 354,
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(12.0),
                            side: BorderSide(color: Color(0xFFFAAE3F))),
                        onPressed: () async {
                          return await _auth
                              .signInWithEmailAndPassword(_email, _password)
                              .then((value) => print("Approved"))
                              .catchError((value) => print("Error: " + value));
                        },
                        color: Color(0xFFFAAE3F),
                        textColor: Colors.white,
                        child: Text("Login".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: new Text("Don't have an account? Register!"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
