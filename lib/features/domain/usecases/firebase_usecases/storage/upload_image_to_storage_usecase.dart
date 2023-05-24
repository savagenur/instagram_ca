import 'dart:io';

import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';

class UploadImageToStorageUseCase {
  final FirebaseRepository repository;
  UploadImageToStorageUseCase({
    required this.repository,
  });

  Future<String> call(
      File file, bool isPost, String childName) async {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}
