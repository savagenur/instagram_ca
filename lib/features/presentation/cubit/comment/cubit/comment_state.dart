part of 'comment_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentLoaded extends CommentState {
  final List<CommentEntity> comments;
  CommentLoaded({
    required this.comments,
  });
  @override
  List<Object> get props => [
    comments,
  ];
}

class CommentLoading extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentFailure extends CommentState {
  @override
  List<Object> get props => [];
}
