import 'package:instagram_ca/features/counter/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/counter/domain/repositories/firebase_repository.dart';

class GetUsersUseCase {
  final FirebaseRepository repository;
  GetUsersUseCase({
    required this.repository,
  });
  Stream<List<UserEntity>> call(UserEntity user) {
    return repository.getUsers(user);
  }
}
