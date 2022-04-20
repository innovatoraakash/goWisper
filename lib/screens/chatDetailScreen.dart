import 'package:flutter/material.dart';
import 'package:go_wisper/models/messageModel.dart';
import 'package:go_wisper/models/userModel.dart';
import 'package:go_wisper/screens/CameraScreen.dart';
import 'package:go_wisper/screens/CameraView.dart';
import 'package:go_wisper/widget/conversationList.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:go_wisper/widget/ownMessageCard.dart';
import 'package:go_wisper/widget/replyCard.dart';
import 'package:go_wisper/models/globalVariable.dart' as Glob;
import 'package:image_picker/image_picker.dart';
import 'package:giphy_picker/giphy_picker.dart';

class ChatDetails extends StatefulWidget {
  ChatDetails({Key key, this.chatData}) : super(key: key);
  final ConversationList chatData;

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  IO.Socket socket;
  ImagePicker _picker = ImagePicker();
  XFile file;
  @override
  void initState() {
    print("Connected xa ra?");
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.18.28:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();
    socket.emit("signin", widget.chatData.userName);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
      print(socket.connected);
    });
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    if (mounted) {
      setState(() {
        messages.add(messageModel);
      });
    }
  }

  Widget build(BuildContext context) {
    final chatData =
        ModalRoute.of(context).settings.arguments as ConversationList;
    return Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              CircleAvatar(
                backgroundImage: AssetImage(chatData.imageUrl),
              ),
            ],
          ),
          title: Text(
            chatData.name.toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: () {},
                child: Icon(Icons.call),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 5),
              child: InkWell(
                onTap: () {},
                child: Icon(Icons.video_call),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Delete chat"),
                    value: "delete",
                  ),
                  PopupMenuItem(
                    child: Text("Unfriend"),
                    value: "unfriend",
                  ),
                  PopupMenuItem(
                    child: Text("move to spam"),
                    value: "Starred messages",
                  ),
                  PopupMenuItem(
                    child: Text("Settings"),
                    value: "Settings",
                  ),
                ];
              },
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffF6F9FF),
          child: Expanded(
            // height: MediaQuery.of(context).size.height - 150,
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: messages.length + 1,
              itemBuilder: (context, index) {
                if (index == messages.length) {
                  return Container(
                    height: 70,
                  );
                }
                if (messages[index].type == "source") {
                  return OwnMessageCard(
                    message: messages[index].message,
                    time: messages[index].time,
                  );
                } else {
                  return ReplyCard(
                    message: messages[index].message,
                    time: messages[index].time,
                  );
                }
              },
            ),
          ),
        ),
        bottomSheet: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          child: Expanded(
            child: Card(
              color: Color(0xffF6F9FF),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () async {
                              final gif = await GiphyPicker.pickGif(
                                  context: context,
                                  apiKey: 'XcW8PHuLvbjS4iprgQAOAoLea8Q5f4SB');
                            },
                            child: Icon(Icons.emoji_emotions)),
                        SizedBox(
                          width: 40,
                        ),
                        InkWell(
                            onTap: () async {
                              file = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraViewPage(
                                            path: file.path,
                                          )));
                            },
                            child: Icon(Icons.file_copy_rounded)),
                        SizedBox(
                          width: 40,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CameraScreen()),
                              );
                            },
                            child: Icon(Icons.camera_alt)),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        minLines: 1,
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              sendButton = true;
                            });
                          } else {
                            setState(() {
                              sendButton = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: Theme.of(context).primaryColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: "Type a message",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    sendButton
                        ? InkWell(
                            child: Icon(Icons.send),
                            onTap: () {
                              sendMessage(_controller.text, Glob.myUserId,
                                  widget.chatData.userName);
                              setState(() {
                                _controller.clear();
                                sendButton = false;
                              });
                            },
                          )
                        : Icon(Icons.cancel_schedule_send),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
