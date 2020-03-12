import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialSuite/UI/SocialMediaSelector.dart';


  String _igUsername, _igPassword; 

Widget instagramLoginPanel() {
  return Container(
    width: 350,
    child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          GestureDetector(
            child: Transform(
                child: Align(
                widthFactor: 23.5,
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset('assets/DownArrow.svg'),
              ),
              transform:  new Matrix4.rotationZ(-1.56), 
              ),
              onTap: () => swipeDown(),
          ),
          Image.asset('assets/images/InstagramTx.png'),
        ],
      ),
    ),
  );
}

