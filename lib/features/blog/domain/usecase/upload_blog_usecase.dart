import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCase<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUsecase({required this.blogRepository});
  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        posterId: params.posterId,
        topics: params.topics,
        content: params.content,
        title: params.title,
        image: params.image);
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams(
    this.posterId,
    this.title,
    this.content,
    this.image,
    this.topics,
  );
}
