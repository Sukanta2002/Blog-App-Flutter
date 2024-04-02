import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDatasource {
  Session? get currentSession;

  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUser();
}

class AuthSupabaseDatasourceImpl implements AuthSupabaseDatasource {
  final SupabaseClient supabaseClient;

  AuthSupabaseDatasourceImpl(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (res.user == null) {
        throw ServerExecption('User is null');
      }
      return UserModel.fromJson(res.user!.toJson());
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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
      return UserModel.fromJson(responce.user!.toJson());
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentSession == null) {
        throw ServerExecption('User is Null');
      }
      final user = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentSession!.user.id);
      return UserModel.fromJson(user.first)
          .copyWith(email: currentSession!.user.email);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
