import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    Image blueCircle = new Image.asset("assets/images/Blue_Circle.png");
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -250,
              right: -170,
              height: 600,
              width: 600,
              child: blueCircle,
            ),
            Positioned(
              bottom: -400,
              right: -15,
              height: 600,
              width: 600,
              child: Image.asset("assets/images/Teal_Circle.png"),
            ),
            Positioned(
              left: 10,
              top: 45,
              width: 40,
              height: 60,
              child: Image.asset("assets/images/leftkeyboardarrow.png"),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 130, 20, 20),
                  child: Text("Lets get started.",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w600,
                          fontSize: 40)),
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 600,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.55),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                            )
                          ]
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text("Email",
                              style: TextStyle(
                                  color: Color(0xFF85C0B9),
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text("Password",
                              style: TextStyle(
                                  color: Color(0xFF85C0B9),
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20)),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: new Theme(
                              data: new ThemeData(
                                primaryColor: Color(0xFF1E99F2),
                                accentColor: Colors.tealAccent,
                                hintColor: Colors.grey,
                              ),
                              child: TextField(),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text("Confirm password",
                              style: TextStyle(
                                  color: Color(0xFF85C0B9),
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
