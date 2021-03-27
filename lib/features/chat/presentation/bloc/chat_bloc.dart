import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/send_message.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_conversation.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetConversation getConversation;
  final SendMessage sendMessage;

  ChatBloc({this.getConversation, this.sendMessage}) : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is GetConversationEvent) {
      yield LoadingConversation();

      yield* getConversation(Params(conversationID: "21")).fold(
          (failure) async* {
        yield ErrorConversation();
      }, (stream) async* {
        yield LoadedConversation(stream: stream);
      });
    } else if (event is SendMessageEvent) {
      yield SendingMessage();

      final eitherSendedOrFailure = await sendMessage(SendMessageParams(
          conversationID: event.conversationID, message: event.message));

      yield* eitherSendedOrFailure.fold((failure) async* {
        yield ErrorSendingMessage();
      }, (bool) async* {
        yield SendedeMessage();
      });
    }
  }
}
