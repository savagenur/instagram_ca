part of 'get_single_post_cubit.dart';

abstract class GetSinglePostState extends Equatable {
  const GetSinglePostState();

  @override
  List<Object> get props => [];
}

class GetSinglePostInitial extends GetSinglePostState {
  @override
  List<Object> get props => [];
}

class GetSinglePostLoaded extends GetSinglePostState {
  final PostEntity postEntity;
  GetSinglePostLoaded({
    required this.postEntity,
  });

  @override
  List<Object> get props => [
        postEntity,
      ];
}

class GetSinglePostLoading extends GetSinglePostState {
  @override
  List<Object> get props => [];
}

class GetSinglePostFailure extends GetSinglePostState {
  @override
  List<Object> get props => [];
}
