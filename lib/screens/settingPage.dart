import 'package:flutter/material.dart';

class settingPage extends StatefulWidget {
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'goWisper',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Theme.of(context).primaryColor),
            ),
            line(280),
            settingTag('Profile'),
            line(160),
            settingTag('Theme'),
            line(160),
            settingTag('About Us'),
            line(160),
            settingTag('Delete Account'),
            line(160),
            settingTag('Log Out'),
            line(160),
          ],
        ),
      ),
    );
  }

  Text settingTag(String data) {
    return Text(data,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ));
  }

  Container line(double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 23),
      height: 2,
      width: width,
      color: Theme.of(context).primaryColor,
    );
  }
}
