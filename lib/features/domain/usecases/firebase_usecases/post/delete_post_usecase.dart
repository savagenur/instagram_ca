import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class DeletePostUseCase {
  final FirebaseRepository repository;
  DeletePostUseCase({
    required this.repository,
  });

  Future<void> call(PostEntity postEntity) async =>
      repository.deletePost(postEntity);

}
