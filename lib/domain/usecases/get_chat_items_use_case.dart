import 'package:whatsapp/data/chat_repository.dart';
import 'package:whatsapp/error/failures.dart';
import 'package:whatsapp/data/model/chat_item.dart';
import 'package:dartz/dartz.dart';

class GetChatItemsUseCase {
  final ChatRepository chatRepository;

  GetChatItemsUseCase({required this.chatRepository});

  Future<Either<Failure, List<ChatItemModel>>> call() async {
    try {
      final chatItems = await chatRepository.getChatItems();
      return Right(chatItems);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch chat items. Please try again later.'));
    }
  }
}
