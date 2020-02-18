import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Firebase/AuthService.dart';
import 'package:socialSuite/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> 
{
  AuthService _auth = new AuthService();
  FirebaseUser _currentUser;
  FirebaseAuth _fb;
  
  bool _loaded = false;

  @override
  void initState() async { 
    super.initState();

    _fb = FirebaseAuth.instance;
    await _getCurrentUser(); 
    print('here outside async');
  }

  _getCurrentUser() async {
    _currentUser = await _fb.currentUser();
    print('hello' + _currentUser.displayName.toString());
    setState(() {
      (_currentUser != null) ? _loaded = true : _loaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if(_loaded != false)
    {
    return Scaffold(
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Text(_currentUser.uid.toString()),
          FlatButton(onPressed: () async {
            _auth.signOut();
          }, child: Text("Sign Out")),
          FlatButton(onPressed: () async {
            _getCurrentUser();
          }, child: Text("Get Current User")),

          new StreamBuilder(
            stream: Firestore.instance.collection('User').document(_currentUser.displayName.toString()).snapshots(),
            builder: (context, snapshot)
            {
              if(!snapshot.hasData)
              {
                return new Text("Loading");
              }
              var userDocuments = snapshot.data;
              return new Text(userDocuments["Email: "].toString());
            }
          ),
        ],
      ),
     ),
    );
  } else {
    return Scaffold(body: Center(child: Text("Loading..."),),);
  }
}
}