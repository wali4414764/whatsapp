class Message {
  final String id;
  final String text;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
  });
}
