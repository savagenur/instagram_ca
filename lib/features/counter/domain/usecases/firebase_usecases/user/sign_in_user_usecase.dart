import 'package:instagram_ca/features/counter/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/counter/domain/repositories/firebase_repository.dart';

class SignInUserUseCase {
  final FirebaseRepository repository;
  SignInUserUseCase({
    required this.repository,
  });

  Future<void> call(UserEntity user) {
    return repository.signInUser(user);
  }
}
