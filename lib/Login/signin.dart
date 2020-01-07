import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:wecycle/CameraManager/cameramanager.dart';
import 'package:wecycle/main.dart';
import 'package:wecycle/globals.dart' as globals;
import 'package:wecycle/services/Authentication.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  AnimationController _slideCirclesController;
  AnimationController _textShowController;
  AnimationController _showLoginController;

  Animation<Offset> _slideBlueCircleAnimation;
  Animation<Offset> _slideTealCircleAnimation;
  Animation<double> _welcomeTextAnimation;
  Animation<double> _showLoginAnimation;

  AuthService authService = new AuthService();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextField emailTextField;
  TextField passwordTextField;

  @override
  void initState() {
    super.initState();
    _slideCirclesController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _slideBlueCircleAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0),
      end: Offset.zero,
    ).animate(_slideCirclesController);
    _slideTealCircleAnimation = Tween<Offset>(
      begin: Offset(1.0, 0),
      end: Offset.zero,
    ).animate(_slideCirclesController);
    _textShowController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _showLoginController = AnimationController(duration: const Duration(milliseconds: 1000),vsync: this);
    _welcomeTextAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_textShowController);
    _showLoginAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_showLoginController);

    _slideCirclesController.forward().then((state) {
      _textShowController.forward().then((state) {
        _showLoginController.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Icon leftArrow = Platform.isAndroid
        ? Icon(Icons.arrow_back, color: Colors.white, size: 30)
        : Icon(Icons.arrow_back_ios, color: Colors.white, size: 30);

    emailTextField = TextField(
        controller: emailController,
        decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Color(0xFF00839B)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFF00839B)))));

    passwordTextField = TextField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Color(0xFF00839B)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFF00839B)))));

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
              child: SlideTransition(
                position: _slideTealCircleAnimation,
                child: globals.tealCircle,
              ),
            ),
            Positioned(
              top: -180,
              right: 10,
              height: 600,
              width: 600,
              child: SlideTransition(
                position: _slideBlueCircleAnimation,
                child: globals.blueCircle,
              ),
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
                FadeTransition(
                  opacity: _welcomeTextAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                    child: Text("Welcome back.",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                        )),
                  ),
                ),
                FadeTransition(
                  opacity: _showLoginAnimation,
                  child: Stack(
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 60),
                            child: emailTextField,
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 60),
                            child: passwordTextField,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                            child: FlatButton(
                              onPressed: () {
                                //TODO: ADD AUTHENTICATION
                                authService.signInWithEmailAndPassword(emailController.text, passwordController.text).then((firebaseUser) {
                                    if(firebaseUser != null){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CameraManager()),
                                      );
                                    } else {
                                      //TODO: ADD FAILURE
                                    }
                                });
                              },
                              color: const Color(0xFF1E99F2),
                              padding:
                              const EdgeInsets.fromLTRB(100, 15, 100, 15),
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40.0),
                                  side: BorderSide(color: const Color(0xFF1E99F2))
                                      .scale(2)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
