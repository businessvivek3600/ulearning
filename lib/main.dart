import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ulearning_app/blocs/index.dart';
import 'package:ulearning_app/firebase_options.dart';

import 'views/pages/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  TextInput.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...Blocs.blocs],
      child: ScreenUtilInit(
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
            return MaterialApp(
              title: 'Ulearning App',
              debugShowCheckedModeBanner: false,
              themeAnimationCurve: Curves.fastLinearToSlowEaseIn,
              themeMode: themeState.themeMode,
              theme: themeState.themeData,
              navigatorObservers: [FlutterSmartDialog.observer],
              builder: FlutterSmartDialog.init(),
              initialRoute: LoginPage.routeName,
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case Splash.routeName:
                    return route(const Splash(), settings: settings);
                  case Welcome.routeName:
                    return route(const Welcome(), settings: settings);
                  case HomePage.routeName:
                    return route(const HomePage(), settings: settings);
                  case LoginPage.routeName:
                    return route(const LoginPage(), settings: settings);
                  case SignUpPage.routeName:
                    return route(const SignUpPage(), settings: settings);
                  default:
                    return route(const LoginPage(), settings: settings);
                }
              },
            );
          });
        },
      ),
    );
  }
}

PageRoute route(
  Widget page, {
  RouteSettings? settings,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool allowSnapshotting = true,
  bool barrierDismissible = false,
}) {
  return MaterialPageRoute(
    builder: (_) => page,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
    allowSnapshotting: allowSnapshotting,
    barrierDismissible: barrierDismissible,
  );
}
