import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Core/AuthService.dart';
import 'package:socialSuite/Core/DatabaseService.dart';
import 'package:socialSuite/Core/Models/User.dart';
import 'package:socialSuite/UI/Profile.dart';
import 'package:socialSuite/UI/SocialMediaSelector.dart';

class GettingStarted extends StatefulWidget {
  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SocialMediaSelector()),
          );
        },
      child: Image.asset("assets/images/GettingStarted.png")  
      ),
    );
  }
}
