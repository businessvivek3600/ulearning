import 'package:flutter/material.dart';
import 'package:ulearning_app/constants/img_const.dart';
import 'package:ulearning_app/utils/extentions/context.dart';
import 'package:ulearning_app/utils/index.dart';

import '../welcome/welcome.dart';

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
    delay(2).then((value) => goTo(context, Welcome.routeName, replace: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          MyPng.logo,
          width: context.screenSize.width * 0.5,
        ),
      ),
    );
  }
}
