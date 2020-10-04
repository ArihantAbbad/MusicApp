import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'welcomeScreen.dart';

void main() async {
  await FlutterDownloader.initialize(debug: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
      home: SafeArea(
        child: Scaffold(
          body: WelcomeScreen(),
        ),
      ),
    );
  }
}
