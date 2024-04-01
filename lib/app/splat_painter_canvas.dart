import "package:flame/game.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/scheduler.dart";

import "../features/splat_painter/splat_painter.dart";

class SplatPainterCanvas extends StatefulWidget {
  const SplatPainterCanvas({super.key});

  @override
  State<SplatPainterCanvas> createState() => _SplatPainterCanvasState();
}

class _SplatPainterCanvasState extends State<SplatPainterCanvas>
    with WidgetsBindingObserver {
  late SplatPainter splatPainter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    splatPainter = SplatPainter(isDarkMode: isDarkMode);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    splatPainter.isDarkMode = isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: splatPainter,
      mouseCursor: SystemMouseCursors.none,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<SplatPainter>(
          "splatPainter",
          splatPainter,
        ),
      )
      ..add(DiagnosticsProperty<bool>("isDarkMode", isDarkMode));
  }

  bool get isDarkMode =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.dark;
}
