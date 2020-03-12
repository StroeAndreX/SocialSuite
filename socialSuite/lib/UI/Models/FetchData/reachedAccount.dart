import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Core/DatabaseService.dart';
import 'package:socialSuite/Core/FetchData.dart';
import 'package:socialSuite/Core/Models/IGUserModel.dart';
import 'package:socialSuite/Core/Models/User.dart';

import '../ConversionDate.dart';

class ReachedAccounts extends StatefulWidget {
  @override
  _ReachedAccountsState createState() => _ReachedAccountsState();
}

class _ReachedAccountsState extends State<ReachedAccounts> {
  Future<List<IGMyInsights>> reachedAccounts;
  FetchData _fetchData = new FetchData();

  @override
  Widget build(BuildContext context) {
  User user = Provider.of<User>(context);
  
 return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            reachedAccounts = _fetchData.accountsReacted(userData.username, userData.password, userData.userID);
            return FutureBuilder<List<IGMyInsights>>(
                future: reachedAccounts,
                builder: (context, snapshot) {
                if (snapshot.hasData){
                      List<IGMyInsights> posts = snapshot.data;
                      return new Column(
                          children: posts.map((post) => new Column(
                            children: <Widget>[
                              Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                                Text("Account Reached:" + post.userReached_value),
                                SizedBox(width: 10),
                                Text("Day:" + post.userReached_label)
                              ],)
                            ],
                          )).toList()
                      );
                    } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              );
          } else {
            return Center(child: Text("Loading..."),);
          }
        });
  }
}