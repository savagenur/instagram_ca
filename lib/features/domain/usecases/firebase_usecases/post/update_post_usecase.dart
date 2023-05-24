import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class UpdatePostUseCase {
  final FirebaseRepository repository;
  UpdatePostUseCase({
    required this.repository,
  });

  Future<void> call(PostEntity postEntity) async =>
      repository.updatePost(postEntity);
}
