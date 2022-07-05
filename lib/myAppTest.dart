
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:frontend/ChatScreen.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

StreamController<List<String>> streamController = StreamController();
String ws_url = "ws://localhost:8080/socket";
String destination = "topic/chat";
String message_destination = "/app/message";
var _listMessage = <String>[];


class MyAppTest extends StatefulWidget {
  const MyAppTest({Key? key}) : super(key: key);

  @override
  State<MyAppTest> createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest> {

  @override
  void initState() {
    super.initState();
    stompClient.activate();
    streamController.add(_listMessage);
  }

  @override
  Widget build(BuildContext context) {
    return const ChatScreen();
  }
}

void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: destination,
    callback: (frame) {
      Map<String, dynamic> result = json.decode(frame.body!);
      //receive Message from topic
      _listMessage.add(result['content']);

      //Observe list message
      streamController.sink.add(_listMessage);
    },
  );
}

final stompClient = StompClient(
  config: StompConfig(
    url: ws_url,
    onConnect: onConnect,
    onWebSocketError: (dynamic error) => print(error.toString()),
  ),
);




class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Web Socket")),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(child:  StreamBuilder(
                stream: streamController.stream,
                builder: (context,snapshot){
                  if (snapshot.hasData) {
                    var listMessage = snapshot.data as List<String>;
                    return ListView.builder(shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return Padding(padding: const EdgeInsets.only(right: 10.0),
                              child: Text(listMessage[index], style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right));
                        },
                        itemCount: listMessage.length);
                  }
                  return const CircularProgressIndicator();
                },
              ), flex: 5),
              Expanded(child:
              Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: TextFormField(
                      controller: textEditingController,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Message',
                      ),
                    ),
                  ), flex: 5),
                  Expanded(child: IconButton(
                    icon: const Icon(Icons.send_rounded),
                    onPressed: (){
                      stompClient.send(
                        destination: message_destination,
                        body: json.encode({'messageContent': textEditingController.text}),
                      );
                    },
                  ), flex: 1,)
                ],
              ), flex: 1),
            ],
          )
      ),
    );
  }
}
