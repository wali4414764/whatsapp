import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/data/model/message.dart';


class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    try {
      await _firestore.collection('messages').doc(message.id).set(message.toJson());
    } catch (e) {
      print("Error sending message: $e");
      throw e;
    }
  }

  Stream<List<Message>> getMessages(String userId) {
    try {
      return _firestore
          .collection('messages')
          .where('senderId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList());
    } catch (e) {
      print("Error getting messages: $e");
      return Stream.empty();
    }
  }
}
