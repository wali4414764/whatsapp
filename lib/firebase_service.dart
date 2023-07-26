import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    try {
      await _firestore.collection('messages').doc(message.id).set({
        'text': message.text,
        'senderId': message.senderId,
        'receiverId': message.receiverId,
        'timestamp': message.timestamp,
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Stream<List<Message>> getMessages(String userId) {
    try {
      return _firestore
          .collection('messages')
          .where('senderId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Message(
          id: doc.id,
          text: data['text'],
          senderId: data['senderId'],
          receiverId: data['receiverId'],
          timestamp: data['timestamp'].toDate(),
        );
      }).toList());
    } catch (e) {
      print("Error getting messages: $e");
      return Stream.empty();
    }
  }
}
