import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double height;

  const DashedLine({
    super.key,
    this.color = Colors.black,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(color: color, dashWidth: dashWidth, dashSpace: dashSpace, height: height),
      size: Size(double.infinity, height),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double height;

  _DashedLinePainter({required this.color, required this.dashWidth, required this.dashSpace, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}