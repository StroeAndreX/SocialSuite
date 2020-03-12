import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Core/Models/User.dart';
import 'package:socialSuite/UI/GettingStarted.dart';

import 'Login.dart';
import 'Profile.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    if(user == null) 
    {
      return Login(); 
    }
    else
    {
     return Profile();
    }
  }

}

