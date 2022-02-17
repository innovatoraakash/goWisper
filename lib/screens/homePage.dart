import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_wisper/models/globalVariable.dart' as Glob;
import 'package:go_wisper/screens/chatPage.dart';
import 'chatPage.dart';
import 'settingPage.dart';
import 'groupChat.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget homepage = ChatPage();
  int index = 0;
  @override
  void initState() {
    setState(() {
      Glob.myUserName = 'shiva';
    });
    // TODO: implement initState
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
