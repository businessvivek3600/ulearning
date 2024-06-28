import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/blocs/auth/providers/providers.dart';
import '../../repository/auth_repository.dart';
import '../../model/user_model.dart';
import '../../utils/extentions/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(const AuthState()) {
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email, status: AuthStatus.initial));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password, status: AuthStatus.initial));
  }

  Future<void> _onLoginSubmitted(
      AuthLoginSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final res = await authRepository.login(event.provider,
          email: state.email, password: state.password);
      emit(state.copyWith(
          status: res.$1 ? AuthStatus.success : AuthStatus.failure,
          user: res.$2,
          message: res.$3 ?? 'Login successful'));
    } on UnhandledException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onRegisterSubmitted(
      AuthRegisterSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final res = await authRepository.register(event.provider as EmailAuth,
          email: state.email, password: state.password);
      emit(state.copyWith(
          status: res.$1 ? AuthStatus.success : AuthStatus.failure,
          user: res.$2,
          message: res.$3 ?? 'Registration successful'));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }
}
