import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_ca/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_ca/features/data/data_sources/remote_data_source/remote_data_source_impl.dart';
import 'package:instagram_ca/features/data/repository/firebase_repository_impl.dart';
import 'package:instagram_ca/features/domain/repository/firebase_repository.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/read_single_post_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/create_user_with_image_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/get_users_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'package:instagram_ca/features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/comment/cubit/comment_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/post/cubit/post_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:instagram_ca/features/presentation/cubit/user/get_single_user/cubit/get_single_user_cubit.dart';

import 'features/domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/read_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/like_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/read_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';
import 'features/presentation/cubit/post/get_single_post/cubit/get_single_post_cubit.dart';

// Service locator = sl
final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Cubits

  sl.registerFactory(() => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));

  sl.registerFactory(() => CredentialCubit(
      signInUserUseCase: sl.call(), signUpUserUseCase: sl.call()));

  sl.registerFactory(() =>
      UserCubit(updateUserUseCase: sl.call(), getUsersUseCase: sl.call()));

  sl.registerFactory(() => GetSingleUserCubit(getSingleUserUseCase: sl.call()));
  sl.registerFactory(() => PostCubit(
      createPostUseCase: sl.call(),
      deletePostUseCase: sl.call(),
      updatePostUseCase: sl.call(),
      likePostUseCase: sl.call(),
      readPostUseCase: sl.call()));

  sl.registerFactory(() => GetSinglePostCubit(readSinglePostUsecase: sl.call()));

  sl.registerFactory(() => CommentCubit(
      createCommentUsecase: sl.call(),
      deleteCommentUsecase: sl.call(),
      likeCommentUsecase: sl.call(),
      readCommentUsecase: sl.call(),
      updateCommentUsecase: sl.call()));
  // User UseCases
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => CreateUserWithImageUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));

  // Post Usecases
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadSinglePostUsecase(repository: sl.call()));

  // Comment Usecases
  sl.registerLazySingleton(() => CreateCommentUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteCommentUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeCommentUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadCommentsUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateCommentUsecase(repository: sl.call()));

  // Cloud Storage
  sl.registerLazySingleton(
      () => UploadImageToStorageUseCase(repository: sl.call()));

  // Repository

  // Abstract classes specify as
  // sl.registerLazySingleton<FirebaseRepository>
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          firebaseFirestore: sl.call(),
          firebaseAuth: sl.call(),
          firebaseStorage: sl.call()));

  // Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  ;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
