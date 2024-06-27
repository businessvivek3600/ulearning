import 'package:flutter/material.dart';

extension IntExt on int {
  Widget get width => SizedBox(width: toDouble());
  Widget get height => SizedBox(height: toDouble());
  Duration get second => Duration(seconds: this);
  Duration get milliseconds => Duration(milliseconds: this);
}
