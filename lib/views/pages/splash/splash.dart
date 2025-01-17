import 'package:flutter/material.dart';
import 'package:ulearning_app/constants/asset_const.dart';
import 'package:ulearning_app/services/auth_service.dart';
import 'package:ulearning_app/utils/extentions/context.dart';
import 'package:ulearning_app/utils/index.dart';
import 'package:ulearning_app/views/pages/index.dart';

import '../../../routes/index.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const String routeName = '/splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    delay(200).then((_) async => AuthService.instance.isAuth).then((value) =>
        goTo(value ? LandingPage.routeName : Welcome.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(MyPng.logo, width: context.screenSize.width * 0.5),
      ),
    );
  }
}
