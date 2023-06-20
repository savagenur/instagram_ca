import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:instagram_ca/features/domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';

import '../../../../domain/entities/comment/comment_entity.dart';
import '../../../../domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import '../../../../domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import '../../../../domain/usecases/firebase_usecases/comment/read_comment_usecase.dart';
import '../../../../domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUsecase createCommentUsecase;
  final DeleteCommentUsecase deleteCommentUsecase;
  final LikeCommentUsecase likeCommentUsecase;
  final ReadCommentsUsecase readCommentUsecase;
  final UpdateCommentUsecase updateCommentUsecase;
  CommentCubit({
    required this.createCommentUsecase,
    required this.deleteCommentUsecase,
    required this.likeCommentUsecase,
    required this.readCommentUsecase,
    required this.updateCommentUsecase,
  }) : super(CommentInitial());

  Future<void> getComments({required String postId}) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentUsecase.call(postId);
       streamResponse.listen((comments) {
        try {
          emit(CommentLoaded(comments: comments));
          
        } catch (e) {
          
        }
        });
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> likeComment({required CommentEntity commentEntity}) async {
    try {
      await likeCommentUsecase.call(commentEntity);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> deleteComment({required CommentEntity commentEntity}) async {
    try {
      await deleteCommentUsecase.call(commentEntity);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> createComment({required CommentEntity commentEntity}) async {
    try {
      await createCommentUsecase.call(commentEntity);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> updateComment({required CommentEntity commentEntity}) async {
    try {
      await updateCommentUsecase.call(commentEntity);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
}
