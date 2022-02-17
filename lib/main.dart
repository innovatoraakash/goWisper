import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'screens/loginPage.dart';
// import 'package:flutter_session/flutter_session.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // dynamic token = FlutterSession().get("token");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          backgroundColor: Color(0xffF6F9FF),
          primaryColor: Color(0xFFC4C4C4),
          // primaryColorDark: Colors.deepPurple,
          primaryColorLight: Color(0xFFC4C4C4)),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
