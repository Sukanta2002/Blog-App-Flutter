part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

final class BlogUploadSucess extends BlogState {}

final class BlogGetSucess extends BlogState {
  final List<BlogEntity> blogs;

  BlogGetSucess(this.blogs);
}
