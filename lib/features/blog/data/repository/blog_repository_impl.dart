import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:blog_app/core/entities/blog_entity.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/blog/data/datasource/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/datasource/blog_supabash_datasource.dart';
import 'package:blog_app/features/blog/data/models/blog_models.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogSupabaseDatasource blogSupabaseDatasource;
  final ConnectionChecker connectionChecker;
  final BlogLoaclDatasouece blogLoaclDatasouece;

  BlogRepositoryImpl({
    required this.blogSupabaseDatasource,
    required this.connectionChecker,
    required this.blogLoaclDatasouece,
  });
  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required List<String> topics,
    required String content,
    required String title,
    required File image,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("Internet is not present!"));
      }
      final blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        content: content,
        topics: topics,
        imageUrl: '',
        title: title,
        updatedAt: DateTime.now(),
      );
      final imageUrl =
          await blogSupabaseDatasource.uploadImage(image, blogModel);
      final blog = blogModel.copyWith(imageUrl: imageUrl);

      final updatedBlog = await blogSupabaseDatasource.uploadBlog(blog);
      return right(updatedBlog);
    } on ServerExecption catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLoaclDatasouece.getBlogs();
        if (blogs.isNotEmpty) {
          return right(blogs);
        }
        return left(Failure("Internet is not present!"));
      }

      final blogs = await blogSupabaseDatasource.getAllBlogs();
      blogLoaclDatasouece.uploadBlogs(blogs);
      return right(blogs);
    } on ServerExecption catch (e) {
      return left(Failure(e.message));
    }
  }
}
