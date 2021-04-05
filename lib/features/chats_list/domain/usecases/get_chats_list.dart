import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/entities/chat.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/repositories/chats_list_repository.dart';

class GetChatsList extends UseCase<List<Chat>, ChatsListParams> {
  final ChatListRepository chatListRepository;

  GetChatsList(this.chatListRepository);

  @override
  Future<Either<Failure, List<Chat>>> call(ChatsListParams params) {
    return chatListRepository.getChatsFromUser(params.user);
  }
}

class ChatsListParams extends Equatable {
  final UserModel user;

  ChatsListParams({@required this.user});

  @override
  List<Object> get props => [];
}
