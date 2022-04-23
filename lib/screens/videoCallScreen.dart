import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:go_wisper/models/globalVariable.dart';

class videoCall extends StatefulWidget {
  @override
  _videoCallState createState() => _videoCallState();
}

class _videoCallState extends State<videoCall> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: agoraApi,
      channelName: "test",
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          AgoraVideoViewer(
            client: client,
          ),
          AgoraVideoButtons(
            client: client,
          ),
        ],
      ),
    );
  }
}
