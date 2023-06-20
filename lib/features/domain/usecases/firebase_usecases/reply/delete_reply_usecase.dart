import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

import '../../../entities/reply/reply_entity.dart';

class DeleteReplyUsecase {
  final FirebaseRepository repository;
  DeleteReplyUsecase({
    required this.repository,
  });

  Future<void> call(ReplyEntity replyEntity) async {
    return repository.deleteReply(replyEntity);
  }
}
