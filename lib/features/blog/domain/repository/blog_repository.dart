import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required List<String> topics,
    required String content,
    required String title,
    required File image,
  });

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();
}
