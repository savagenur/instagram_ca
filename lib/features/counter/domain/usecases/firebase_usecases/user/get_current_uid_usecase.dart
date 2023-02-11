import 'package:instagram_ca/features/counter/domain/repositories/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;
  GetCurrentUidUseCase({
    required this.repository,
  });
  Future<String> call() {
    return repository.getCurrentUid();
  }
}
