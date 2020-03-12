import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:socialSuite/Core/AuthService.dart';
import 'package:socialSuite/Core/Authentification.dart';
import 'package:socialSuite/Core/Models/User.dart';
import 'package:socialSuite/UI/Models/InstagramLogin.dart';
import 'package:socialSuite/UI/Profile.dart';
import 'package:socialSuite/UI/Register.dart';

class SocialMediaSelector extends StatefulWidget {
  @override
  _SocialMediaSelectorState createState() => _SocialMediaSelectorState();
}

PanelController _pc = new PanelController();
RESTFULApi _api = new RESTFULApi();
void swipeUp() {
  _pc.show().then((value) => _pc.open());
}

void swipeDown() {
  _pc.close().then((value) => _pc.hide());
}

class _SocialMediaSelectorState extends State<SocialMediaSelector> {
  String _igUsername, _igPassword;

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (val) {
              (title == "Instagram Username")
                  ? setState(() => _igUsername = val)
                  : setState(() => _igPassword = val);
            },
            obscureText: isPassword,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: title,
                suffixIcon:
                    (title == "Email") ? Icon(Icons.email) : Icon(Icons.https)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _pc.hide());
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      backgroundColor: Color(0xFFFAAE3F),
      body: SlidingUpPanel(
        maxHeight: 590,
        isDraggable: false,
        borderRadius: radius,
        controller: _pc,
        panel: Column(
          children: <Widget>[
            instagramLoginPanel(),
            Container(
                width: 350,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60),
                    _entryField("Instagram Username"),
                    SizedBox(height: 60),
                    _entryField("Password Username", isPassword: true),
                    SizedBox(height: 80),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(12.0),
                            side: BorderSide(color: Color(0xFFFAAE3F))),
                        onPressed: () async {
                          return await _api
                              .login(_igUsername, _igPassword, user.uid)
                              .then(
                                (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile())),
                              );
                        },
                        color: Color(0xFFFAAE3F),
                        textColor: Colors.white,
                        child: Text("Login".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                ))
          ],
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 96),
          Container(
            width: 414,
            height: 800,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 3.0,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0) //         <--- border radius here
                  ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                SvgPicture.asset('assets/images/Logo.svg'),
                SizedBox(height: 10),
                Text(
                  "SocialSuite",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Roboto'),
                ),
                SizedBox(height: 8),
                Text(
                  "Connect with your SocialMedia",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
                ),
                SizedBox(height: 100),
                SizedBox(
                  width: 360,
                  height: 45,
                  child: RaisedButton.icon(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () => swipeUp(),
                    color: Colors.white,
                    textColor: Colors.white,
                    icon: SvgPicture.asset('assets/images/Instagram.svg'),
                    label: Text("Connect your instagram Account",
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 360,
                  height: 45,
                  child: RaisedButton.icon(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () => null,
                    color: Colors.white,
                    textColor: Colors.white,
                    icon: SvgPicture.asset('assets/images/Twitter.svg'),
                    label: Text("Connect your Twitter Account",
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 360,
                  height: 45,
                  child: RaisedButton.icon(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () => null,
                    color: Colors.white,
                    textColor: Colors.white,
                    icon: Image.asset('assets/images/TikTok.png'),
                    label: Text("Connect your TikTok Account",
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 360,
                  height: 45,
                  child: RaisedButton.icon(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () => null,
                    color: Colors.white,
                    textColor: Colors.white,
                    icon: SvgPicture.asset('assets/images/Youtube.svg'),
                    label: Text("Connect your Youtube Account",
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                ),
                SizedBox(height: 40),
                Text("More in the future...")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
