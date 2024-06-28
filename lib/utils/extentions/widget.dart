import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension WidgetExt on Widget {
  Widget fitted({
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
    Alignment alignment = Alignment.center,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: fit,
        alignment: alignment,
        clipBehavior: Clip.hardEdge,
        child: this,
      ),
    );
  }

  Widget padding({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? all,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        start: left ?? 0,
        end: right ?? 0,
      ),
      child: this,
    );
  }

  Widget paddingAll(double padding) {
    return Padding(padding: EdgeInsetsDirectional.all(padding), child: this);
  }

  Widget paddingSymmetric({double? vertical, double? horizontal}) {
    return Padding(
        padding: EdgeInsetsDirectional.symmetric(
            vertical: vertical ?? 0, horizontal: horizontal ?? 0),
        child: this);
  }

  Widget margin({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? all,
  }) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        start: left ?? 0,
        end: right ?? 0,
      ),
      child: this,
    );
  }

  Widget row({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    List<Widget> children = const [],
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [this, ...children],
      );

  Widget size({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget centerLeft() => Row(children: [const Spacer(), this]);

  Widget centerRight() => Row(children: [this, const Spacer()]);

  Widget centerTop() => Column(children: [const Spacer(), this]);

  Widget centerBottom() => Column(children: [this, const Spacer()]);

  Widget center() => Center(child: this);

  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  Widget background(Color color) => Container(color: color, child: this);

  Widget borderRadius(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  Widget elevation(double elevation) =>
      Material(elevation: elevation, child: this);

  Widget shadow(
      {Color color = Colors.black,
      double blurRadius = 10,
      double spreadRadius = 0,
      Offset offset = Offset.zero}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
            offset: offset,
          ),
        ],
      ),
      child: this,
    );
  }

  Widget onTap(
    VoidCallback onTap, {
    double radius = 100,
  }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          // splashColor: Colors.blue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Center(child: this),
          ),
        ),
      );

  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);

  Widget onDoubleTap(VoidCallback onDoubleTap) =>
      GestureDetector(onDoubleTap: onDoubleTap, child: this);

  Widget onHorizontalDrag(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onHorizontalDragUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      child: this,
    );
  }

  Widget onVerticalDrag(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onVerticalDragUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: this,
    );
  }

  Widget onPan(DragStartBehavior dragStartBehavior,
      GestureDragUpdateCallback onPanUpdate) {
    return GestureDetector(
      dragStartBehavior: dragStartBehavior,
      onPanUpdate: onPanUpdate,
      child: this,
    );
  }

  Widget scrollable({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    EdgeInsetsGeometry? padding,
    bool? primary,
    ScrollPhysics? physics,
    ScrollController? controller,
    Widget? child,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Clip clipBehavior = Clip.hardEdge,
    String? restorationId,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
  }) =>
      SingleChildScrollView(
        key: key,
        scrollDirection: scrollDirection,
        reverse: reverse,
        padding: padding,
        primary: primary,
        physics: physics,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        child: this,
      );
}
