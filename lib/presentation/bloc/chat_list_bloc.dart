import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp/error/failures.dart';
import 'package:whatsapp/data/model/chat_item.dart';
import 'package:whatsapp/domain/usecases/get_chat_items_use_case.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetChatItemsUseCase getChatItemsUseCase;

  ChatListBloc({required this.getChatItemsUseCase}) : super(ChatListInitial());

  @override
  Stream<ChatListState> mapEventToState(
      ChatListEvent event,
      ) async* {
    if (event is LoadChatList) {
      yield* _mapLoadChatListToState();
    }
  }

  Stream<ChatListState> _mapLoadChatListToState() async* {
    yield ChatListLoading();
    final failureOrChatItems = await getChatItemsUseCase();
    yield failureOrChatItems.fold(
          (failure) => ChatListError(message: _mapFailureToMessage(failure)),
          (chatItems) => ChatListLoaded(chatItems: chatItems),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Logic to map different failure types to user-friendly error messages
    if (failure is ServerFailure) {
      return 'Server Failure: Please try again later.';
    } else if (failure is NetworkFailure) {
      return 'Network Failure: Please check your internet connection.';
    } else {
      return 'Unknown Failure: An unexpected error occurred.';
    }
  }
}
