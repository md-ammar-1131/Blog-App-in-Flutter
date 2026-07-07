part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

//loading ,failure ,success
final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

final class BlogSuccessUpload extends BlogState {}

final class BlogSuccessDisplay extends BlogState {
  final List<Blog> blogs;

  BlogSuccessDisplay({required this.blogs});
}
