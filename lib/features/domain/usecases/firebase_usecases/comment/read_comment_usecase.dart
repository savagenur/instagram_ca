import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class ReadCommentsUsecase {
  final FirebaseRepository repository;
  ReadCommentsUsecase({
    required this.repository,
  });

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}
