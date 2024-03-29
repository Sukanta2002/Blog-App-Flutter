// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUsecase implements UseCase<String, UserSignupParams> {
  final AuthRepository authRepository;

  SignUpUsecase(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignupParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;
  UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
