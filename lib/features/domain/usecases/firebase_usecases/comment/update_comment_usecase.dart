import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class CreateCommentUsecase {
  final FirebaseRepository repository;
  CreateCommentUsecase({
    required this.repository,
  });

  Future<void> call(CommentEntity commentEntity) async {
    return repository.createComment(commentEntity);
  }
}
