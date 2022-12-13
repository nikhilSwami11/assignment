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

    // This function will return the number of semicircles to draw according to the design
    final int curveToDraw = _calculateNumberOfCurves(nodes);

    for (int i = 0; i < curveToDraw; i++) {
      // This factor will define the width of horizontal line in the snake path
      final widthFactor = isOddI ? 0.75 : 0.25;
      // 1
      path.lineTo(size.width * widthFactor, initialDepth + i * diameterOfCurve);
      //2
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width * widthFactor,
              initialDepth + diameterOfCurve / 2 + i * diameterOfCurve),
          height: diameterOfCurve,
          width: diameterOfCurve,
        ),
        isOddI ? -pi / 2 : pi / 2,
        pi,
        false,
        paint,
      );
      //3
      path.moveTo(
        size.width * widthFactor,
        initialDepth + diameterOfCurve * (i + 1),
      );
      //4
      path.lineTo(
        size.width * 0.5,
        initialDepth + diameterOfCurve * (i + 1),
      );
      canvas.drawPath(path, paint);
      isOddI = !isOddI;
    }
    //1 ->      -       // half line
    //2 ->     (        // semicircle
    //3,4 ->    -       // rebase the to the end of semicircle and draw a line from there
    //1 loop->   -      // complete the half line
    //2 loop->    )
    //3 loop ->  -
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
