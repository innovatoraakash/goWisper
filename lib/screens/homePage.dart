import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_wisper/models/globalVariable.dart' as Glob;
import 'package:go_wisper/screens/chatPage.dart';
import 'chatPage.dart';
import 'settingPage.dart';
import 'groupChat.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User currentUser = FirebaseAuth.instance.currentUser;
  emailVerification() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    // await currentUser.sendEmailVerification();
  }

  Widget homepage = ChatPage();
  int index = 0;
  @override
  void initState() {
    setState(() {
      Glob.myUserId = currentUser.uid;
    });

    // implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: settingPage(),
        appBar: AppBar(
          backgroundColor: Color(0xffF6F9FF),
          shadowColor: Colors.white30,
          title: Text(
            'CHATS',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 32,
            ),
          ),
        ),
        body: Container(
          child: homepage,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (int index) {
            setState(() {
              this.index = index;
              index == 1 ? homepage = groupChat() : homepage = ChatPage();
            });
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade800,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'chats',
              // activeIcon: Text('activated')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'groups',
              // activeIcon: settingPage()
            ),
          ],
        ));
  }
}
