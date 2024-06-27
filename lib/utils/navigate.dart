import 'package:flutter/material.dart';

Future<T?> goTo<T extends Object?>(BuildContext context, String name,
    {Object? arg, bool replace = true}) async {
  return !replace
      ? Navigator.of(context).pushNamedAndRemoveUntil(name, (route) => false)
      : Navigator.of(context).pushReplacementNamed(name, arguments: arg);
}

Future<T?> pushTo<T extends Object?>(BuildContext context, String name,
    {Object? arg}) async {
  return Navigator.of(context).pushNamed(name, arguments: arg);
}

// Future<T?> goTo<T extends Object?>(BuildContext context, String name,
//     {RouteSettings? settings, bool replace = true}) async {
//   return !replace
//       ? Navigator.of(context).pushNamedAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => page, settings: settings),
//           (route) => false)
//       : Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => page, settings: settings),
//         );
// }

// Future<T?> goToAndBack<T extends Object?>(BuildContext context, Widget page,
//     {RouteSettings? settings}) async {
//   return Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => page, settings: settings),
//       (route) => true);
// }

// Future<T?> pushTo<T extends Object?>(BuildContext context, Widget page,
//     {RouteSettings? settings}) async {
//   return Navigator.of(context)
//       .push(MaterialPageRoute(builder: (context) => page, settings: settings));
// }
