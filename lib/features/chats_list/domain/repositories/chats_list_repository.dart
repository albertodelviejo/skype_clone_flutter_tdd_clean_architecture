import 'package:dartz/dartz.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/entities/chat.dart';

abstract class ChatListRepository {
  Future<Either<Failure, List<Chat>>> getChatsFromUser(UserModel user);
}
