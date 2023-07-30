import 'package:flutter/material.dart';

class ChatItemModel {
  String name;
  String mostRecentMessage;
  String messageDate;

  ChatItemModel(this.name, this.mostRecentMessage, this.messageDate);
}

class ChatItem extends StatelessWidget {
  final ChatItemModel chatItem;

  ChatItem(this.chatItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ),
      title: Text(
        chatItem.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(chatItem.mostRecentMessage),
          Text(
            chatItem.messageDate,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
      onTap: () {
        // Add your desired functionality when a chat item is tapped
      },
    );
  }
}
