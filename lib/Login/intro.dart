import 'package:flutter/material.dart';
import 'package:wecycle/Login/signin.dart';
import 'package:wecycle/Login/signup.dart';
import 'package:wecycle/globals.dart' as globals;

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: globals.tealCircle,
            bottom: -140,
            left: -80,
            width: 600,
            height: 600,
          ),
          Positioned(
            child: globals.blueCircle,
            top: -150,
            left: -60,
            width: 600,
            height: 600,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      "To...",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 130, 0, 0),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60,0,60,80),
                        child: null,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "We",
                              style: TextStyle(
                                  color: Color(0xFF00D555),
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 70),
                            ),
                            Text(
                              "Cycle",
                              style: TextStyle(
                                  color: Color(0xFF00B0ED),
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 70),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xFF38829C),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0),
                        side: BorderSide(color: Colors.white).scale(2)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: const Color(0xFF1E99F2)),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0),
                        side: BorderSide(color: Colors.white).scale(2)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
