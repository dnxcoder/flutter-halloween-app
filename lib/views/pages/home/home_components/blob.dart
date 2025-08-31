import 'package:flutter/material.dart';

class Blob extends StatelessWidget {
  const Blob({
    super.key,
    this.width = 220,
    this.height = 140,
    this.color = const Color(0xFFEF5A3C),
    this.strokeColor,
    this.strokeWidth = 2,
  });

  final double width;
  final double height;
  final Color color;
  final Color? strokeColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _BlobPainter(
        fill: color,
        stroke: strokeColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter({required this.fill, this.stroke, this.strokeWidth = 2});

  final Color fill;
  final Color? stroke;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Path “pingo”/blob com uma leve “mordida” no meio
    final path = Path()
      ..moveTo(w * 0.18, h * 0.50)
      ..cubicTo(w * 0.18, h * 0.25, w * 0.42, h * 0.08, w * 0.62, h * 0.20)
      ..cubicTo(w * 0.88, h * 0.34, w * 0.90, h * 0.62, w * 0.74, h * 0.72)
      ..cubicTo(w * 0.58, h * 0.82, w * 0.43, h * 0.67, w * 0.34, h * 0.70)
      ..cubicTo(w * 0.18, h * 0.76, w * 0.10, h * 0.62, w * 0.18, h * 0.50)
      ..close();

    // preenchimento
    final fillPaint = Paint()..color = fill;
    canvas.drawPath(path, fillPaint);

    // contorno opcional (tipo o branco fininho da imagem)
    if (stroke != null && strokeWidth > 0) {
      final strokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = stroke!;
      canvas.drawPath(path, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BlobPainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.stroke != stroke ||
      oldDelegate.strokeWidth != strokeWidth;
}
