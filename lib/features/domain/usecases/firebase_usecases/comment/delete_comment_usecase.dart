import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class DeleteCommentUsecase {
  final FirebaseRepository repository;
  DeleteCommentUsecase({
    required this.repository,
  });

  Future<void> call(CommentEntity commentEntity) async {
    return repository.deleteComment(commentEntity);
  }
}
