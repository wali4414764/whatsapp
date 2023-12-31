import 'package:flutter/material.dart';
import 'package:whatsapp/data/model/message.dart';
import 'package:whatsapp/data/sources/firebase_service.dart';


class ChatList extends StatefulWidget {
  final String userId;

  ChatList({required this.userId});

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: _firebaseService.getMessages(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<Message> messages = snapshot.data ?? [];

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            Message message = messages[index];
            return ListTile(
              title: Text(message.text),
              subtitle: Text("Sent at: ${message.timestamp}"),
            );
          },
        );
      },
    );
  }
}
