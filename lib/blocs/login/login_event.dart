part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class LoginEmailChanged extends LoginEvent { 
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginAttemptEvent extends LoginEvent {
  final LoginMethod socialAuth;

  const LoginAttemptEvent(this.socialAuth);

  @override
  List<Object?> get props => [socialAuth];
}

class RegisterAttemptEvent extends LoginEvent {
  final LoginMethod socialAuth;

  const RegisterAttemptEvent(this.socialAuth);

  @override
  List<Object?> get props => [socialAuth];
}

class LoginSubmitted extends LoginEvent {}
