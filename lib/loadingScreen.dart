import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_app/welcomeScreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return WelcomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              "Melody ♫♫",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Image.asset(
                  "images/smok.gif",
                ),
              ),
              SizedBox(
                height: size.height * 0.20,
              ),
              Flexible(
                child: Image.asset(
                  "images/gifs.gif",
                  height: size.height * 0.10,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                "Loading...",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
