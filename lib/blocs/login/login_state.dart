part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final String? message;
  final LoginStatus status;

  const LoginState({
    this.email = '',
    this.password = '',
    this.message,
    this.status = LoginStatus.initial,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? message,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, message, status];
}

class LoginInitial extends LoginState {
  const LoginInitial() : super(status: LoginStatus.initial);
}

class LoginLoading extends LoginState {
  const LoginLoading({
    super.email,
    super.password,
    super.message,
  }) : super(
          status: LoginStatus.loading,
        );
}

class LoginSuccess extends LoginState {
  const LoginSuccess({
    super.email,
    super.password,
    super.message,
  }) : super(
          status: LoginStatus.success,
        );
}

class LoginFailure extends LoginState {
  const LoginFailure({
    super.email,
    super.password,
    super.message,
  }) : super(
          status: LoginStatus.failure,
        );
}
