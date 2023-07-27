class ChatItemModel {
  String name;
  String mostRecentMessage;
  String messageDate;

  ChatItemModel(this.name, this.mostRecentMessage, this.messageDate);
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