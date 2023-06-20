import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

import '../../../entities/reply/reply_entity.dart';

class LikeReplyUsecase {
  final FirebaseRepository repository;
  LikeReplyUsecase({
    required this.repository,
  });

  Future<void> call(ReplyEntity replyEntity) async {
    return repository.likeReply(replyEntity);
  }
}
