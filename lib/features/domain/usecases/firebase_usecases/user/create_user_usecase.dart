
import '../../../entities/user_entity.dart';
import '../../../repository/firebase_repository.dart';

class CreateUserUseCase {
  final FirebaseRepository repository;
  CreateUserUseCase({
    required this.repository,
  });
  Future<void> call(UserEntity userEntity) {
    return repository.createUser(userEntity);
  }
}
