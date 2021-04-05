import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/data/datasources/chat_list_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/entities/chat.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/repositories/chats_list_repository.dart';

class ChatListRepositoryImpl implements ChatListRepository {
  final ChatListDataSource chatListDataSource;

  ChatListRepositoryImpl(this.chatListDataSource);
  @override
  Future<Either<Failure, List<Chat>>> getChatsFromUser(UserModel user) async {
    try {
      final result = await chatListDataSource.getChatsFromUser(user);
      return Right(result);
    } on Exception {
      return Left(GetChatsFailure());
    }
  }
}
