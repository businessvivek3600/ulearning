import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/utils/index.dart';
import 'package:ulearning_app/views/pages/index.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(LoginInitial(email: event.email, password: state.password));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(LoginInitial(email: state.email, password: event.password));
    });
    on<LoginAttemptEvent>(_handleLogin);
  }

  void _handleLogin(LoginAttemptEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading(email: state.email, password: state.password));
    logg('Login attempt email ${state.email} ${state.password}');
    // var type = event is SocialLoginEvent ? Sociala : 'Email';
    var res = await LoginRepo.instance
        .login(event.socialAuth, email: state.email, password: state.password);
    logg(res.$2 ?? '');
    if (res.$1) {
      emit(LoginSuccess(
          email: state.email, password: state.password, message: res.$2));
    } else {
      emit(LoginFailure(
          email: state.email,
          password: state.password,
          message: res.$2 ?? 'Login failed'));
    }
  }
}
