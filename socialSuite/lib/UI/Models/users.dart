import 'package:flutter/material.dart';

Widget users(String image_url, String username)
{
  return Container(
    height: 50,
    child: Row(children: <Widget>[
      SizedBox(width: 20),
      CircleAvatar(
        backgroundImage: NetworkImage(image_url),
      ),
      SizedBox(width: 40),
      Text(username),
    ],),    
  );
}