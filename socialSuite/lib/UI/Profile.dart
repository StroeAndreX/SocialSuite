import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Core/AuthService.dart';
import 'package:socialSuite/Core/DatabaseService.dart';
import 'package:socialSuite/Core/Models/User.dart';
import 'package:socialSuite/UI/Login.dart';
import 'package:socialSuite/UI/Models/BusinessData.dart';

import 'Models/FollowerListPage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  //State class
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AuthService _auth = new AuthService();

    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
          bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: Colors.white24,
          color: Color(0xFFFAAE3F),
          items: <Widget>[
            Icon(Icons.person, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: (_page == 0) ? BusinessSection() : (_page == 1) ? FollowerListPage() : 
          Center(child: FlatButton(onPressed: () => _auth.signOut().then(
            (value) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login())),
          ), child: Text("Sign Out"))));
  }
  
}
