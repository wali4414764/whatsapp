import 'package:whatsapp/data/chat_repository.dart';
import 'package:whatsapp/data/model/message.dart';
import 'package:whatsapp/domain/usecases/usecases.dart';
import 'package:whatsapp/error/failures.dart';
import 'package:dartz/dartz.dart';

class SendMessageUseCase implements UseCase<void, Message> {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Message message) async {
    return await repository.sendMessage(message);
  }
}
