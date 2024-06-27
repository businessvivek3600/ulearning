part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginAttemptEvent extends LoginEvent {
  final LoginMethod socialAuth;

  LoginAttemptEvent(this.socialAuth);
}

class LoginSubmitted extends LoginEvent {}
