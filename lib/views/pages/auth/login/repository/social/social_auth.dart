import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../../utils/index.dart';

sealed class LoginMethod {
  Future<SocialAuthResult> login();

  Future<SocialAuthResult> loggout();

  Future<SocialAuthResult> forgotPassword();

  Future<SocialAuthResult> changePassword();
}

abstract class SocialAuth extends LoginMethod {
  @override
  Future<SocialAuthResult> login();

  @override
  Future<SocialAuthResult> loggout();

  @override
  Future<SocialAuthResult> forgotPassword();

  @override
  Future<SocialAuthResult> changePassword();
}

mixin SocialAuthLoggging on LoginMethod {
  @override
  Future<SocialAuthResult> login() async {
    logg('Starting loggin process', name: runtimeType);
    final result = await super.login();
    logg('Loggin process completed', name: runtimeType);
    return result;
  }

  @override
  Future<SocialAuthResult> loggout() async {
    logg('Starting loggout process', name: runtimeType);
    final result = await super.loggout();
    logg('Loggout process completed', name: runtimeType);
    return result;
  }

  @override
  Future<SocialAuthResult> forgotPassword() async {
    logg('Starting forgotPassword process', name: runtimeType);
    final result = await super.forgotPassword();
    logg('ForgotPassword process completed', name: runtimeType);
    return result;
  }

  @override
  Future<SocialAuthResult> changePassword() async {
    logg('Starting changePassword process', name: runtimeType);
    final result = await super.changePassword();
    logg('ChangePassword process completed', name: runtimeType);
    return result;
  }
}

class SocialAuthResult {
  final bool success;
  final String message;
  final SocialUser? user;

  SocialAuthResult.success(this.user, [this.message = '']) : success = true;
  SocialAuthResult.failure([this.message = '', this.user]) : success = false;

  SocialAuthResult({required this.success, required this.message, this.user});

  SocialAuthResult copyWith({
    bool? success,
    String? message,
    SocialUser? user,
  }) {
    return SocialAuthResult(
      success: success ?? this.success,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  SocialAuthResult.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        user = json['user'];

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user,
    };
  }
}

class SocialUser {
  final String primaryId;
  final String uid;
  final String? email;
  final String? name;
  final String? photoUrl;
  final String? phoneNumber;

  SocialUser({
    required this.primaryId,
    required this.uid,
    this.email,
    this.name,
    this.photoUrl,
    this.phoneNumber,
  });

  SocialUser copyWith({
    String? primaryId,
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    String? phoneNumber,
  }) {
    return SocialUser(
      primaryId: primaryId ?? this.primaryId,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  SocialUser.fromJson(Map<String, dynamic> json)
      : primaryId = json['primaryId'],
        uid = json['uid'],
        email = json['email'],
        name = json['name'],
        photoUrl = json['photoUrl'],
        phoneNumber = json['phoneNumber'];

  Map<String, dynamic> toJson() {
    return {
      'primaryId': primaryId,
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
    };
  }
}

class GoogleAuth extends SocialAuth {
  @override
  Future<SocialAuthResult> login() async {
    try {
      await loggout();
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return SocialAuthResult(
            success: false, message: 'Google Sign In failed');
      }

      // Get the Google Sign In Authentication
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google Auth Credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      // Get the user
      final User? user = userCredential.user;

      // Return the user
      return SocialAuthResult(
        success: true,
        message: 'Google Sign In successful',
        user: SocialUser(
          primaryId: googleUser.id,
          uid: user!.uid,
          email: user.email,
          name: user.displayName,
          photoUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
        ),
      );
    } catch (e) {
      // Return null if there is an error
      return SocialAuthResult(
          success: false, message: 'Google Sign In failed $e');
    }
  }

  @override
  Future<SocialAuthResult> changePassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> loggout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return SocialAuthResult(
      success: true,
      message: 'Loggged out successfully',
    );
  }
}

class FacebookAuth extends SocialAuth {
  @override
  Future<SocialAuthResult> login() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> changePassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> loggout() {
    throw UnimplementedError();
  }
}

class AppleAuth extends SocialAuth {
  @override
  Future<SocialAuthResult> login() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> changePassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> loggout() {
    throw UnimplementedError();
  }
}

class EmailAuth extends LoginMethod {
  String email;
  String password;
  EmailAuth({required this.email, required this.password});
  @override
  Future<SocialAuthResult> login() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> changePassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<SocialAuthResult> loggout() {
    throw UnimplementedError();
  }

  Future<void> register() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      logg('Register failed', error: e, name: 'EmailAuth');
    }
  }
}
