// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: ((context, index) => ListTile(
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2020/12/15/10/22/hinata-5833262_960_720.png")),
              title: Text("Name"),
              subtitle: Text("Last Message"),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("12:00:00"),
                  Icon(CupertinoIcons.volume_off),
                ],
              ),
            )));
  }
}
