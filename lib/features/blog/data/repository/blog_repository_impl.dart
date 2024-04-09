import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/data/datasource/blog_supabash_datasource.dart';
import 'package:blog_app/features/blog/data/models/blog_models.dart';

import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogSupabaseDatasource blogSupabaseDatasource;

  BlogRepositoryImpl({required this.blogSupabaseDatasource});
  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required List<String> topics,
    required String content,
    required String title,
    required File image,
  }) async {
    try {
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
      print(updatedBlog);
      return right(updatedBlog);
    } on ServerExecption catch (e) {
      return left(Failure(e.message));
    }
  }
}
