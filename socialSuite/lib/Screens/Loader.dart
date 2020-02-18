import 'package:socialSuite/Screens/Auth/Auth.dart';
import 'package:socialSuite/Screens/Pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/user.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    if(user == null) 
    {
      return Auth(); 
    }
    else
    {
     return Profile();
    }
  }
}


