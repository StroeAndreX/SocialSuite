import 'package:flutter/material.dart';
import 'package:socialSuite/Screens/Auth/Login.dart';
import 'package:socialSuite/Screens/Auth/Register.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}