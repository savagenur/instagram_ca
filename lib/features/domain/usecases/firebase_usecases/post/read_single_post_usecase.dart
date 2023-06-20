import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class ReadSinglePostUsecase {
  final FirebaseRepository repository;
  ReadSinglePostUsecase({
    required this.repository,
  });

  Stream<List<PostEntity>> call(String postId) {
    return repository.readSinglePost(postId);
  }
}
