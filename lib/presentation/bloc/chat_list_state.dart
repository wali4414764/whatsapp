part of 'chat_list_bloc.dart';

class ChatListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<ChatItemModel> chatItems;

  ChatListLoaded({required this.chatItems});

  @override
  List<Object?> get props => [chatItems];
}

class ChatListError extends ChatListState {
  final String message;

  ChatListError({required this.message});

  @override
  List<Object?> get props => [message];
}
