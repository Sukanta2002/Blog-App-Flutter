import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogSupabaseDatasource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadImage(
    File image,
    BlogModel blog,
  );
}

class BlogSupabaseDataSourceImpl implements BlogSupabaseDatasource {
  final SupabaseClient supabaseClient;

  BlogSupabaseDataSourceImpl({
    required this.supabaseClient,
  });
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final updatedBlog =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(updatedBlog.first);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<String> uploadImage(File image, BlogModel blog) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_image').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
