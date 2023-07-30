import 'package:dartz/dartz.dart';
import 'package:whatsapp/data/model/message.dart';
import 'package:whatsapp/data/chat_repository.dart';
import 'package:whatsapp/domain/usecases/usecases.dart';
import 'package:whatsapp/error/failures.dart';

class GetMessagesUseCase implements UseCase<List<Message>, String> {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Message>>> call(String userId) {
    try {
      return repository.getMessages(userId).first.then(
            (messages) => Right(messages),
        onError: (e) => Left(Failure("Error getting messages")),
      );
    } catch (e) {
      print("Error getting messages: $e");
      return Future.value(Left(Failure("Error getting messages")));
    }
  }
}
