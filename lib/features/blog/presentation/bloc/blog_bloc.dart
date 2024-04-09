import 'dart:io';

import 'package:blog_app/features/blog/domain/usecase/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  BlogBloc({required UploadBlogUsecase uploadBlogUsecase})
      : _uploadBlogUsecase = uploadBlogUsecase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);
  }

  void _blogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlogUsecase(UploadBlogParams(
      event.posterId,
      event.title,
      event.content,
      event.image,
      event.topics,
    ));
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogSucess()),
    );
  }
}
