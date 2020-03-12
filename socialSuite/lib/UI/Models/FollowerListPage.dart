import 'package:flutter/material.dart';
import 'package:socialSuite/UI/Models/FetchData/followerList.dart';

class FollowerListPage extends StatefulWidget {
  @override
  _FollowerListPageState createState() => _FollowerListPageState();
}

class _FollowerListPageState extends State<FollowerListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(child: FollowersList(),),
      
    );
  }
}