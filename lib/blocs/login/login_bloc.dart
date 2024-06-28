import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning_app/utils/index.dart';
import 'package:ulearning_app/views/pages/index.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginInitialEvent>((event, emit) => emit(const LoginInitial()));
    on<LoginEmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<LoginPasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginAttemptEvent>(_handleLogin);
    on<RegisterAttemptEvent>(_handleRegistration);
  }

  Future<void> _handleRegistration(
    RegisterAttemptEvent event, 
    Emitter<LoginState> emit
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    logg('Register attempt email ${state.email} ${state.password}');
    
    var res = await LoginRepo.instance.register(
      event.socialAuth,
      email: state.email,
      password: state.password
    );
    
    logg(res.$2 ?? '', name: "_handleRegistration");
    if (res.$1) {
      emit(state.copyWith(
        status: LoginStatus.success,
        message: res.$2,
      ));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        message: res.$2 ?? 'Registration failed',
      ));
    }
  }

  Future<void> _handleLogin(
    LoginAttemptEvent event, 
    Emitter<LoginState> emit
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    logg('Login attempt email ${state.email} ${state.password}');
    
    var res = await LoginRepo.instance.login(
      event.socialAuth,
      email: state.email,
      password: state.password
    );
    
    logg(res.$2 ?? '');
    if (res.$1) {
      emit(state.copyWith(
        status: LoginStatus.success,
        message: res.$2,
      ));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        message: res.$2 ?? 'Login failed',
      ));
    }
  }
}
