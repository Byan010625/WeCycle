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

              stops: [0.0, 0.95, 1.0],
              colors: [
                const Color(0xFF1DBCF7),
                const Color(0xFF1E99F2),
                const Color(0xFF1F7AEE),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Welcome, User \n\tTo...",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('assets/images/WeCycle.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: FlatButton(
                  onPressed: null,
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.white)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: FlatButton(
                  onPressed: () {print("Hello");},
                  color: Colors.white,
                  textColor: Colors.blue,
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF1E99F2)
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                      side: BorderSide(color: const Color(0xFF1E99F2))
                  ),
                ),
              ),
            ],
          ),
        ),
    );

  }
}
