import 'dart:async';
import 'package:ulearning_app/blocs/auth/providers/providers.dart';
import 'package:ulearning_app/model/auth_result.dart';

import '../model/user_model.dart';

enum AuthProvider { google, facebook, apple, email }

class AuthRepository {
  Future<(bool, AuthUser?, String?)> login(AuthProviderInterface provider,
      {String? email, String? password}) async {
    AuthResult result = await provider.login();
    return (result.success, result.user, result.message);
  }

  Future<(bool, AuthUser?, String?)> register(EmailAuth provider,
      {String? email, String? password}) async {
    AuthResult result = await provider.register();
    return (result.success, result.user, result.message);
  }

  Future<(bool, AuthUser?, String?)> logout(
      AuthProviderInterface provider) async {
    AuthResult result = await provider.login();
    return (result.success, result.user, result.message);
  }





  
}
