import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDatasource {
  Future<String> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthSupabaseDatasourceImpl implements AuthSupabaseDatasource {
  final SupabaseClient supabaseClient;

  AuthSupabaseDatasourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final responce = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (responce.user == null) {
        throw ServerExecption('User is null');
      }
      return responce.user!.id;
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
