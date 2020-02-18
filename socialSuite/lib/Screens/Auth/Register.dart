import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:socialSuite/Firebase/AuthService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State < Register > {

String email = '';
String password = '';
String username = '';

AuthService _auth = new AuthService();

 Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: title,
            ),
            onChanged: (val) {
              (title == "Email") ? setState(() => email = val) : setState(() => password = val);
            },

            onSubmitted: (val) async {
              return await _auth.registerWithEmailAndPassword(email, password, username);
            },
          ),
        ],
      ),
    );
  }

  Widget _newEntryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: title,
            ),
            onChanged: (val) {
              if(title == "Username") { setState(() {
                username = val;
              });}
            },

            onSubmitted: (val) async {
              return await _auth.registerWithEmailAndPassword(email, password, username);
            },
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfffbb448), Color(0xfff7892b)])),
    child: Text(
      'Register',
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget _divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        Text('or'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

  Widget _title() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'd',
        children: [
          TextSpan(
            text: 'ev',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'rnz',
            style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
          ),
        ]),
  );
  }

  Widget _emailPasswordWidget() {
  return Column(
    children: <Widget>[
      _newEntryField("Username"),
      _entryField("Email"),
      _entryField("Password", isPassword: true),
    ],
  );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                _title(),
                SizedBox(
                  height: 50,
                ),
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password ?',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                _divider(),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _createAccountLabel(),
          ),
          Positioned(top: 40, left: 0, child: _backButton()), 
        ],
      ),
    );
  }
}
