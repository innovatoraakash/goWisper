import 'package:flutter/material.dart';

import 'package:go_wisper/models/userModel.dart';
import 'package:go_wisper/widget/conversationList.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    final chatData =
        ModalRoute.of(context).settings.arguments as ConversationList;
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(chatData.imageUrl),
            ),
          ],
        ),
        title: Text(
          chatData.name.toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Text(chatData.name),
      ),
    );
  }
}
