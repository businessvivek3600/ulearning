part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  final String? message;
  final String email;
  final String password;

  const LoginState({
    this.email = '',
    this.password = '',
    this.message,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? message,
  });
}

class LoginInitial extends LoginState {
  const LoginInitial({
    super.email,
    super.password,
    super.message,
  });

  @override
  LoginInitial copyWith({
    String? email,
    String? password,
    String? message,
  }) {
    return LoginInitial(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }
}

class LoginLoading extends LoginState {
  const LoginLoading({
    super.email,
    super.password,
    super.message,
  });

  @override
  LoginLoading copyWith({
    String? email,
    String? password,
    String? message,
  }) {
    return LoginLoading(
      email: email ?? this.email,
      password: password ?? this.password,
      message: super.message,
    );
  }
}

class LoginSuccess extends LoginState {
  const LoginSuccess({
    super.email,
    super.password,
    super.message,
  });

  @override
  LoginSuccess copyWith({
    String? email,
    String? password,
    String? message,
  }) {
    return LoginSuccess(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }
}

class LoginFailure extends LoginState {
  const LoginFailure({
    super.message,
    super.email,
    super.password,
  });

  @override
  LoginFailure copyWith({
    String? email,
    String? password,
    String? message,
  }) {
    return LoginFailure(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }
}
