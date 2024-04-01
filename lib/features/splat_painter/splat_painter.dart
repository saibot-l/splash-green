import "dart:async";
import "dart:math";

import "package:flame/events.dart";
import "package:flame/game.dart";
import "package:flutter/material.dart";

import "background.dart";
import "cursor.dart";
import "splat.dart";
import "splat_spawner.dart";

class SplatPainter extends FlameGame
    with
        DragCallbacks,
        MouseMovementDetector,
        SingleGameInstance,
        TapCallbacks {
  SplatPainter({
    required bool isDarkMode,
  }) : _isDarkMode = isDarkMode;

  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    background.color = bgColor;
    cursor.color = fgColor;
  }

  late final Background background;
  late final Cursor cursor;
  late final Random random;
  late final SplatEmitter splatEmitter;

  Vector2? _dragOrientation;

  Color get bgColor => isDarkMode
      ? const Color.fromARGB(255, 26, 26, 22)
      : const Color.fromARGB(255, 242, 242, 240);
  Color get fgColor => isDarkMode ? Colors.white : Colors.black;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    random = Random();

    add(background = Background(bgColor));
    add(cursor = Cursor(fgColor)..priority = 10);
    add(
      splatEmitter = SplatEmitter(
        random,
        autoStart: false,
        getDirection: () => _dragOrientation,
      ),
    );
  }

  @override
  void onDragStart(DragStartEvent event) async {
    super.onDragStart(event);
    splatEmitter.center = event.canvasPosition;
    splatEmitter.timer.start();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    cursor.position = event.canvasEndPosition;

    final lastDragOrientation = _dragOrientation;
    _dragOrientation = lastDragOrientation != null
        ? (lastDragOrientation + event.canvasDelta.normalized()).normalized()
        : event.canvasDelta.normalized();

    splatEmitter.center = event.canvasEndPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    splatEmitter.timer.stop();
  }

  @override
  void onTapUp(TapUpEvent event) async {
    super.onTapUp(event);
    await add(
      Splat.positioned(random, position: event.canvasPosition),
    );
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    cursor.position = info.eventPosition.widget;
  }
}
