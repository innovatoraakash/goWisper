import 'package:flutter/material.dart';
import 'package:go_wisper/screens/chatPage.dart';
import 'chatPage.dart';
import 'settingPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'CHATS',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 32,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 13.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Add')
                ],
              ),
            )
          ],
        ),
        body: Container(
          child: ChatPage(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => settingPage()),
              );
            }
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade800,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'chats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'setting',
                activeIcon: settingPage()),
          ],
        ));
  }
}
