import 'package:instagram_ca/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class ReadCommentUsecase {
  final FirebaseRepository repository;
  ReadCommentUsecase({
    required this.repository,
  });

  Stream<List<PostEntity>> call(String postId)  {
    return repository.readComment(postId);
  }
}
