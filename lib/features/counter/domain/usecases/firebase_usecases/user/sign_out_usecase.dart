import 'package:instagram_ca/features/counter/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/counter/domain/repositories/firebase_repository.dart';

class SignOutUseCase {
  final FirebaseRepository repository;
  SignOutUseCase({
    required this.repository,
  });

  Future<void> call() {
    return repository.signOut();
  }
}
