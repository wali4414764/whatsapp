import 'package:flutter/material.dart';

class ChatItemModel {
  String name;
  String mostRecentMessage;
  String messageDate;

  ChatItemModel(this.name, this.mostRecentMessage, this.messageDate);
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ChatHelper.getChatItemCount(),
      itemBuilder: (context, position) {
        ChatItemModel chatItem = ChatHelper.getChatItem(position);

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 64.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                chatItem.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                chatItem.messageDate,
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              chatItem.mostRecentMessage,
                              style:
                              TextStyle(color: Colors.black45, fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}

class ChatHelper {
  static List<ChatItemModel> _chatItems = [
    ChatItemModel('John Doe', 'Hey, how are you?', '1 day ago'),
    ChatItemModel('Alice', 'See you later!', '2 days ago'),
    // Add more chat items here
  ];

  static int getChatItemCount() {
    return _chatItems.length;
  }

  static ChatItemModel getChatItem(int index) {
    return _chatItems[index];
  }
}
