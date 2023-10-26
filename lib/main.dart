import 'package:flutter/material.dart';

void main() {
  runApp(const MyHomePage());
}

// Edit function here:
void _paint(Canvas canvas, Size size) {
  final Rect rect = Offset.zero & size;
  const RadialGradient gradient = RadialGradient(
    center: Alignment(0.7, -0.6),
    radius: 0.2,
    colors: <Color>[Color(0xFFFFFF00), Color(0xFF0099FF)],
    stops: <double>[0.4, 1.0],
  );
  canvas.drawRect(
    rect,
    Paint()..shader = gradient.createShader(rect),
  );
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) => _paint(canvas, size);
  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: MyPainter(),
      );
    }));
  }
}
