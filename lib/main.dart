
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

void main() {
  runApp(const MyHomePage());
}

// Edit function here:
void _paint(Canvas canvas, Size size, ui.Image? image) {
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
  if (image != null) {
    canvas.drawImage(image, const Offset(10, 200), Paint());
  }
}

class MyPainter extends CustomPainter {
  final ui.Image? _image;

  MyPainter(this._image);

  @override
  void paint(Canvas canvas, Size size) => _paint(canvas, size, _image);
  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  ui.Image? _image;

  Future<ui.Image> loadImageFromAssets(String path) async {
    final ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    super.initState();
    loadImageFromAssets('assets/airplane.jpg').then((value) {
      setState(() {
        _image = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: MyPainter(_image),
      );
    });
  }
}
