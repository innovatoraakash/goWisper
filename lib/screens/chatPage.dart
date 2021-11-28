import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_wisper/widget/conversationList.dart';
import 'package:go_wisper/models/chatModel.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                // color: Colors.blueGrey.shade50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        'CHATS',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 13.0),
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
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent.shade100),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'search...',
                ),
              ),
            ),
            ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                })
            // ConversationList(name: 'name', messageText: 'messageText', imageUrl: imageUrl, time: time, isMessageRead: isMessageRead)
          ],
        ),
      ),
    );
  }
}
