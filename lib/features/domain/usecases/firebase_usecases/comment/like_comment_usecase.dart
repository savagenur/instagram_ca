import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class LikeCommentUsecase {
  final FirebaseRepository repository;
  LikeCommentUsecase({
    required this.repository,
  });

  Future<void> call(CommentEntity commentEntity) async {
    return repository.likeComment(commentEntity);
  }
}
