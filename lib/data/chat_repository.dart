import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/data/model/chat_item.dart';
import 'package:whatsapp/data/model/message.dart';
import 'package:whatsapp/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<List<ChatItemModel>> getChatItems();
  Stream<List<Message>> getMessages(String userId);
  Future<Either<Failure, void>> sendMessage(Message message); // Add this method
}

class FirebaseChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ChatItemModel>> getChatItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('chats').get();
      List<ChatItemModel> chatItems = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ChatItemModel(
          data['name'],
          data['mostRecentMessage'],
          data['messageDate'],
        );
      }).toList();
      return chatItems;
    } catch (e) {
      print("Error getting chat items: $e");
      return [];
    }
  }

  @override
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
      // Instead of returning an empty stream, we will throw a Failure
      throw Failure('Error getting messages: $e');
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(Message message) async {
    try {
      // Implement the logic to send the message using Firebase or any other method here
      // For example, you can use Firestore to add the message to a collection
      await _firestore.collection('messages').add(message.toJson());
      return Right(null); // Return a Right if the message is sent successfully
    } catch (e) {
      print("Error sending message: $e");
      return Left(ServerFailure('Failed to send message. Please try again later.'));
    }
  }
}
