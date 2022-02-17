import 'package:flutter/material.dart';
import 'package:go_wisper/screens/chatDetailScreen.dart';

class ConversationList extends StatefulWidget {
  String userName;
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList(
      {@required this.userName,
      @required this.name,
      @required this.messageText,
      @required this.imageUrl,
      @required this.time,
      @required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return ChatDetails(
                    chatData: this.widget,
                  );
                },
                settings: RouteSettings(arguments: widget)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Expanded(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.imageUrl),
              maxRadius: 30,
            ),
            title: Text(
              widget.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w800),
            ),
            trailing: Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
            subtitle: Text(
              widget.messageText,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black87),
            ),
            enableFeedback: true,
          ),
        ),
      ),
    );
  }
}
