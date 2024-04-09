import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogUsecase implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogUsecase({required this.blogRepository});
  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return blogRepository.getAllBlogs();
  }
}
