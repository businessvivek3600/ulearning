import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulearning_app/utils/index.dart';

import '../../../index.dart';

class LoginRepo {
  LoginRepo._();
  static final LoginRepo instance = LoginRepo._();

  Future<(bool, Map<String, dynamic>, String?)> loginWithSocialAuth(
    SocialAuth socialAuth,
  ) async {
    SocialAuthResult result = await socialAuth.login();

    logg('Login with social user ${result.toJson()}', name: 'LoginRepo');

    /// login with social user
    return (result.success, result.user?.toJson() ?? {}, result.message);
  }

  Future<(bool, Map<String, dynamic>, String?)> loginWithCredentials(
      String email, String password) async {
    try {
      var res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logg('Login with email ${res.additionalUserInfo?.profile}',
          name: 'LoginRepo');
      logg('Login with email ${res.additionalUserInfo?.username}',
          name: 'LoginRepo');
      logg('Login with email ${res.user?.displayName}', name: 'LoginRepo');
      if (res.user != null) {
        bool isNewUser = res.additionalUserInfo?.isNewUser ?? false;
        return (
          true,
          SocialUser(
            primaryId: res.user!.uid,
            uid: res.user!.uid,
            email: res.user!.email,
            name: res.user!.displayName,
            photoUrl: res.user!.photoURL,
            phoneNumber: res.user!.phoneNumber,
          ).toJson(),
          isNewUser ? 'Welcome to uLearning 🙌' : "Welcome back",
        );
      }
    } on FirebaseAuthException catch (e) {
      logg('Login with email failed', error: e, name: 'LoginRepo');
      // if (e.code == 'invalid-credential') {
      //   UserCredential userCredential = await FirebaseAuth.instance
      //       .createUserWithEmailAndPassword(email: email, password: password);

      //   /// Send confirmation email
      //   await userCredential.user!.sendEmailVerification();
      //   return (
      //     false,
      //     <String, dynamic>{},
      //     'A verification email has been sent to your email address. Please verify your email address to continue.',
      //   );
      // }

      return (false, <String, dynamic>{}, getFirebaseExceptionMessage(e));
    } catch (e) {
      logg('Login with email failed', error: e, name: 'LoginRepo');
    }
    return (false, <String, dynamic>{}, 'Something went wrong');
  }

  Future<(bool, String?)> login(
    dynamic type, {
    String? email,
    String? password,
  }) async {
    bool isSuccess = false;
    Map<String, dynamic> data = {};
    String? msg;
    try {
      /// show loading
      if (type is SocialAuth) {
        final result = await loginWithSocialAuth(type);
        data = result.$2;
        isSuccess = result.$1;
        msg = result.$3;
      } else if (type is EmailAuth) {
        final result = await loginWithCredentials(email!, password!);
        logg('Login with email $result', name: 'LoginRepo');
        data = result.$2;
        isSuccess = result.$1;
        msg = result.$3;
      } else {
        throw 'Invalid login type';
      }
      if (isSuccess && data.isNotEmpty) {
        /// save user data to local storage
        logg('Login success $data', name: 'LoginRepo', error: data);
      } else {
        /// show error message
        isSuccess = false;
      }
    } catch (e) {
      /// show error message
      isSuccess = false;
      logg('Login failed', error: e, name: 'LoginRepo');
    } finally {
      /// hide loading
    }

    return (isSuccess, msg ?? 'error');
  }
}

String getFirebaseExceptionMessage(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'weak-password':
      return 'Your password is too weak. Please choose a stronger password.';
    case 'email-already-in-use':
      return 'The email address you entered is already in use. Please try a different email address.';
    case 'operation-not-allowed':
      return 'This operation is not allowed. Please contact support.';
    case 'user-disabled':
      return 'The user account is disabled. Please contact support.';
    case 'wrong-password':
      return 'The email address or password is incorrect.';
    case 'account-exists-with-different-credential':
      return 'An account already exists with the same email address but different sign-in credentials. Please link or try signing in with the provider associated with the email address.';
    case 'invalid-credential':
      return 'The provided credential is invalid.';
    case 'credential-already-in-use':
      return 'This credential is already associated with a different user account.';
    default:
      return 'An error occurred. Please try again later.';
  }
}
