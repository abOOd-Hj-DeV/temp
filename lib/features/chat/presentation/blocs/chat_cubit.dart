import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etmaen/features/chat/data/models/message_model.dart';
import 'package:etmaen/features/chat/data/repositories/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  ChatCubit(this.repository) : super(ChatInitial());

  Future<void> getMessages({
    Map<String, dynamic>? queryParameters,
  }) async {
    emit(ChatLoading());
    final result = await repository.getMessages(
      queryParameters: queryParameters,
    );
    result.fold(
      ifLeft: (failure) =>
          emit(ChatError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (messages) => emit(ChatLoaded(messages)),
    );
  }

  Future<void> sendMessage(Map<String, dynamic> data) async {
    emit(ChatLoading());
    final result = await repository.sendMessage(data);
    result.fold(
      ifLeft: (failure) =>
          emit(ChatError(failure.errorMessage ?? 'Unknown error')),
      ifRight: (message) {
        final currentState = state;
        if (currentState is ChatLoaded) {
          emit(ChatLoaded([...currentState.messages, message]));
        } else {
          emit(ChatLoaded([message]));
        }
      },
    );
  }

  Future<void> markAsRead(String id) async {
    await repository.markAsRead(id);
  }
}