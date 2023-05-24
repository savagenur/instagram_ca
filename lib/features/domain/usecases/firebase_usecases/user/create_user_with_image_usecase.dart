import 'package:instagram_ca/features/domain/entities/user_entity.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class CreateUserWithImageUseCase {
  final FirebaseRepository repository;
  CreateUserWithImageUseCase({
    required this.repository,
  });
  Future<void> call(UserEntity userEntity, String profileUrl) async {
    repository.createUserWithImage(userEntity, profileUrl);
  }
}
