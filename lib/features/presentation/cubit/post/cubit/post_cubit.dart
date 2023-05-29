import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/like_post_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/read_post_usecase.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final LikePostUseCase likePostUseCase;
  final ReadPostUseCase readPostUseCase;
  PostCubit({
    required this.createPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
    required this.likePostUseCase,
    required this.readPostUseCase,
  }) : super(PostInitial());

  Future<void> getPosts({required PostEntity postEntity}) async {
    emit(PostLoading());
    try {
      final streamResponse = readPostUseCase.call(postEntity);
      streamResponse.listen((posts) {
        emit(PostLoaded(posts: posts));
      });
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity postEntity}) async {
    try {
      await updatePostUseCase.call(postEntity);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
  Future<void> likePost({required PostEntity postEntity}) async {
    try {
      await likePostUseCase.call(postEntity);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
  Future<void> deletePost({required PostEntity postEntity}) async {
    try {
      await deletePostUseCase.call(postEntity);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
  Future<void> createPost({required PostEntity postEntity}) async {
    try {
      await createPostUseCase.call(postEntity);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
}
