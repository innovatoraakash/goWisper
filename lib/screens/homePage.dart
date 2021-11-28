import 'package:flutter/material.dart';
import 'package:go_wisper/screens/chatPage.dart';
import 'chatPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ChatPage(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade800,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'chats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'setting'),
          ],
        ));
  }
}
