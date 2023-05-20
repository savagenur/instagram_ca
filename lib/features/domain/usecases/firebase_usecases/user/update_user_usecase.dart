import '../../../entities/user_entity.dart';
import '../../../repository/firebase_repository.dart';
class UpdateUserUseCase {
  final FirebaseRepository repository;
  UpdateUserUseCase({
    required this.repository,
  });

  Future<void> call(UserEntity user) {
    return repository.updateUser(user);
  }
}
