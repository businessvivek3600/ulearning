import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/utils/index.dart';

import 'signup/signup_bloc.dart';
import 'login/login_bloc.dart';
import 'welcome/welcome_bloc.dart';
import 'theme/theme_bloc.dart';

export 'login/login_bloc.dart';
export 'signup/signup_bloc.dart';
export 'welcome/welcome_bloc.dart';
export 'theme/theme_bloc.dart';

class Blocs {
  static List<BlocProvider> get blocs => [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
        BlocProvider<WelcomeBloc>(create: (context) => WelcomeBloc()),
      ];
}

///MyBlocObserver

class MyBlocObserver extends BlocObserver {
  String tag = 'BlocObserver';
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // logg('onEvent $event in in ${bloc.runtimeType}', name: tag);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // logg('onChange ${change.runtimeType} in ${bloc.runtimeType}', name: tag);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logg('onError $error in ${bloc.runtimeType}', name: tag);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // logg('onTransition $transition in ${bloc.runtimeType}', name: tag);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logg('onClose $bloc', name: tag);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logg('onCreate $bloc', name: tag);
  }
}