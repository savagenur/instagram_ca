import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:instagram_ca/features/domain/usecases/firebase_usecases/post/read_single_post_usecase.dart';

import '../../../../../domain/entities/post/post_entity.dart';

part 'get_single_post_state.dart';

class GetSinglePostCubit extends Cubit<GetSinglePostState> {
  final ReadSinglePostUsecase readSinglePostUsecase;
  GetSinglePostCubit({
    required this.readSinglePostUsecase,
  }) : super(GetSinglePostInitial());
  Future<void> getSinglePost({required String postId}) async {
    emit(GetSinglePostLoading());
    try {
      final streamResponse = readSinglePostUsecase.call(postId);
      streamResponse.listen((posts) {
        try {
          emit(GetSinglePostLoaded(
              postEntity: posts.first,));
        } catch (e) {}
      });
    } on SocketException catch (_) {
      emit(GetSinglePostFailure());
    } catch (_) {
      emit(GetSinglePostFailure());
    }
  }
}
