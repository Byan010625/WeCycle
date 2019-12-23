import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../CameraManager/cameramanager.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    Image blueCircle = new Image.asset("assets/images/Blue_Circle.png");
    Image tealCircle = new Image.asset("assets/images/Teal_Circle.png");
    Icon leftArrow = Platform.isAndroid ? Icon(Icons.arrow_back, color: Colors.white, size: 30) : Icon(Icons.arrow_back_ios, color: Colors.white, size: 30);

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -180,
              right: -250,
              height: 600,
              width: 600,
              child: tealCircle,
            ),
            Positioned(
              top: -180,
              right: 10,
              height: 600,
              width: 600,
              child: blueCircle,
            ),
            Positioned(
              left: 10,
              top: 45,
              width: 40,
              height: 60,
              child: GestureDetector(
                onTap: () {
                    Navigator.pop(context);
                },
                child: leftArrow,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                  child: Text("Welcome back.",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe',
                    fontWeight: FontWeight.w600,
                    fontSize: 40,)),
                ),
                Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 275, 0),
                          child: Text("Email",
                            style: TextStyle(
                                color: const Color(0xFF00839B),
                              fontFamily: 'Segoe',
                              fontWeight: FontWeight.w400,
                              fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                          child: TextField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF00839B)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF00839B))))),
                              ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 250, 0),
                          //const EdgeInsets.fromLTRB(left, top, right, bottom)
                          child: Text("Password",
                              style: TextStyle(
                                  color: const Color(0xFF00839B),
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                          child: TextField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF00839B)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF00839B))))),
                              ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                          child: FlatButton(
                            onPressed: () {
                              //TODO: ADD AUTHENTICATION
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                  CameraManager()),
                              );
                            },
                            color: const Color(0xFF1E99F2),
                            padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontFamily: 'Segoe',
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                                side: BorderSide(color: const Color(0xFF1E99F2)).scale(2)),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}