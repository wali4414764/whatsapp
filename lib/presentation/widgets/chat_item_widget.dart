import 'package:flutter/material.dart';

class ChatItemWidget extends StatelessWidget {
  final String name;
  final String mostRecentMessage;
  final String messageDate;

  ChatItemWidget({
    required this.name,
    required this.mostRecentMessage,
    required this.messageDate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.person,
          size: 40,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mostRecentMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Text(
            messageDate,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
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
