import 'dart:developer';
import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
   GroupPage({super.key, required this.name});
  final String name;

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  IO.Socket? socket;
  List listMsg = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }
  void connect(){
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      "transports" : ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    log("We are here to connect");
    socket!.onConnect((_){
      log("Connected to frontend.....");
      socket!.emit('sendMsg', 'testing emit event');
    });
  }

  void sendMsg(String msg){
    socket!.emit('sendMsg', {
      "type" : "ownMsg",
      "msg" : msg
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous Group'),  
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Type here...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                      )
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, 
                  icon: const Icon(Icons.send,
                  color: Colors.teal,)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}