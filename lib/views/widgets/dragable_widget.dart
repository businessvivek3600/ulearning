// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ulearning_app/utils/extentions/index.dart';
import 'package:ulearning_app/utils/index.dart';

class DraggableFloatingWidget extends StatefulWidget {
  const DraggableFloatingWidget(
      {super.key, required this.child, required this.floatingWidget});
  final Widget child;
  final Widget floatingWidget;

  @override
  _DraggableFloatingWidgetState createState() =>
      _DraggableFloatingWidgetState();
}

class _DraggableFloatingWidgetState extends State<DraggableFloatingWidget> {
  ValueNotifier<(double, double)> position = ValueNotifier((100.0, 100.0));
  final GlobalKey _key = GlobalKey();
  late Size? _size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
      setState(() => _size = renderBox?.size);
      logg('RenderBox: ${renderBox?.size}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(key: _key, child: widget.child),
        ValueListenableBuilder<(double, double)>(
            valueListenable: position,
            builder: (context, value, child) {
              return Positioned(
                left: value.$1,
                top: value.$2,
                child: Draggable(
                  feedback: widget.floatingWidget,
                  childWhenDragging: Container(),
                  onDragUpdate: (details) {
                    // logg(
                    // 'details: ${details.globalPosition}  ${context.screenSize} ${_size}');
                    if (details.globalPosition.dx < 0 ||
                        details.globalPosition.dy < 0) return;
                    if (details.globalPosition.dx > (_size?.width ?? 40) - 40 ||
                        details.globalPosition.dy >
                            (_size?.height ?? 40) - 40) {
                      return;
                    }
                    position.value =
                        (details.globalPosition.dx, details.globalPosition.dy);
                  },
                  // onDraggableCanceled: (velocity, offset) {
                  //   logg('offset: $offset');
                  //   if (offset.dx < 0 || offset.dy < 0) return;
                  //   if (offset.dx > MediaQuery.of(context).size.width ||
                  //       offset.dy > MediaQuery.of(context).size.height) return;
                  //   position.value = (offset.dx, offset.dy);
                  // },
                  child: widget.floatingWidget,
                ),
              );
            }),
      ],
    );
  }
}
