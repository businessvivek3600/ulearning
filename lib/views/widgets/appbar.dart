import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ulearning_app/utils/extentions/index.dart';
import 'package:ulearning_app/utils/index.dart';
import 'package:ulearning_app/views/widgets/theme_switch_button.dart';

PreferredSize transparentAppBar(
  BuildContext context, {
  String? title,
  double? elevation,
  double? height,
  bool theme = false,
  bool centerTile = false,
  bool transparent = true,
}) {
  transparent = transparent && height == 0;
  SystemUiOverlayStyle systemOverlayStyle = transparent
      ? context.isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark
      : SystemUiOverlayStyle.light;
  return PreferredSize(
    preferredSize: Size.fromHeight(height ?? 0),
    child: AppBar(
      toolbarHeight: height ?? 0,
      centerTitle: centerTile,
      title: title != null ? Text(title) : null,
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: transparent
          ? Colors.transparent
          : Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      actions: [
        if (theme) const ThemeSwitch(),
      ],
    ),
  );
}
