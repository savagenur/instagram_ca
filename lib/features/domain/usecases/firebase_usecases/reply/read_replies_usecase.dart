import 'package:instagram_ca/features/domain/entities/reply/reply_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class ReadRepliesUsecase {
  final FirebaseRepository repository;
  ReadRepliesUsecase({
    required this.repository,
  });

  Stream<List<ReplyEntity>> call(ReplyEntity replyEntity) {
    return repository.readReplies(replyEntity);
  }
}
