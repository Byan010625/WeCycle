import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,

              stops: [0.0, .99, 1.0],
              colors: [
                const Color(0xFF1DBCF7),
                const Color(0xFF1E99F2),
                const Color(0xFF1F7AEE),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 80, 20 , 20),
                  child: Text(
                    "Welcome, User",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20 , 20),
                  child: Text(
                    "To...",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Image.asset('assets/images/WeCycle.png'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 150, 20, 20),
                child: FlatButton(
                  onPressed: null, //TODO: ADD NEXT PAGE
                  padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.white
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0),
                      side: BorderSide(color: Colors.white).scale(2)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20,20),
                child: FlatButton(
                  onPressed: () {}, //TODO: ADD NEXT PAGE
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: const Color(0xFF1E99F2)
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0),
                      side: BorderSide(color: Colors.white).scale(2)),
                ),
              ),
            ],
          ),
        ),
    );

  }
}
