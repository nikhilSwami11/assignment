import 'package:flutter/material.dart';
import 'dart:math';

class SnakePath extends StatelessWidget {
  final int numberOfNodes;
  const SnakePath(this.numberOfNodes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvePainter(nodes: numberOfNodes),
    );
  }
}

class CurvePainter extends CustomPainter {
  final int nodes;

  CurvePainter({required this.nodes});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xFFFF2A2839);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10;

    bool isOddI = false;
    const double diameterOfCurve = 150;
    const double initialDepth = 100;
    var path = Path();
    // Code to Draw the Initial Path Only
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.5, initialDepth);

    final int curveToDraw = _calculateNumberOfCurves(nodes);

    for (int i = 0; i < curveToDraw; i++) {
      final factor = isOddI ? 0.75 : 0.25;
      path.lineTo(size.width * factor, initialDepth + i * diameterOfCurve);
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width * factor,
              initialDepth + diameterOfCurve / 2 + i * diameterOfCurve),
          height: diameterOfCurve,
          width: diameterOfCurve,
        ),
        isOddI ? -pi / 2 : pi / 2,
        pi,
        false,
        paint,
      );
      path.moveTo(
        size.width * factor,
        initialDepth + diameterOfCurve * (i + 1),
      );
      path.lineTo(
        size.width * 0.5,
        initialDepth + diameterOfCurve * (i + 1),
      );
      canvas.drawPath(path, paint);
      isOddI = !isOddI;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  int _calculateNumberOfCurves(int nodes) {
    if (nodes % 3 == 1) {
      return 2 * (nodes / 3).floor() + 1;
    } else if (nodes % 3 == 2) {
      return 2 * (nodes / 3).floor() + 2;
    } else {
      return 2 * ((nodes - 1) / 3).floor() + 2;
    }
  }
}
