import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class ReadPostUseCase {
  final FirebaseRepository repository;
  ReadPostUseCase({
    required this.repository,
  });

    Stream<List<PostEntity>> call(PostEntity postEntity)  =>
      repository.readPost(postEntity);
}
