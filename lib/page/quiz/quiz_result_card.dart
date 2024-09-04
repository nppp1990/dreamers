import 'dart:math';

import 'package:dreamer/common/widget/bg_page.dart';
import 'package:dreamer/constants/colors.dart';
import 'package:dreamer/page/quiz/quiz_page.dart';
import 'package:flutter/material.dart';

class RotateHoleClipper extends CustomClipper<Path> {
  final double left;
  final double top;
  final double radius;
  final double angle;

  RotateHoleClipper({super.reclip, required this.left, required this.top, required this.radius, required this.angle});

  // the distance between point p and line(start, end)
  _calculateDistance(Offset p, Offset start, Offset end) {
    final double a = end.dy - start.dy;
    final double b = start.dx - end.dx;
    final double c = end.dx * start.dy - start.dx * end.dy;
    return (a * p.dx + b * p.dy + c).abs() / sqrt(a * a + b * b);
  }

  // get the point on the circle
  _getCirclePoint(Offset center, double radius, double angle) {
    return Offset(center.dx + sin(angle) * radius, center.dy - cos(angle) * radius);
  }

  @override
  Path getClip(Size size) {
    Offset rectCenter = Offset(size.width / 2, size.height / 2);
    double rectRadius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2));

    final double oldAngle = pi * 2 - atan2(size.width, size.height);
    Offset leftTopPoint = _getCirclePoint(rectCenter, rectRadius, oldAngle + angle);
    Offset rightTopPoint = _getCirclePoint(rectCenter, rectRadius, 2 * pi - oldAngle + angle);
    Offset leftBottomPoint = _getCirclePoint(rectCenter, rectRadius, pi - oldAngle + angle);
    Offset clipperOrigin = Offset(left + radius, top + radius);

    double dx = _calculateDistance(clipperOrigin, leftTopPoint, leftBottomPoint);
    double dy = _calculateDistance(clipperOrigin, leftTopPoint, rightTopPoint);

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: Offset(dx, dy), radius: radius))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HoleClipper extends CustomClipper<Path> {
  final double left;
  final double top;
  final double radius;

  HoleClipper({super.reclip, required this.left, required this.top, required this.radius});

  @override
  Path getClip(Size size) {
    print('$hashCode--------size: $size');
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: Offset(left + radius, top + radius), radius: radius))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class QuizResultContainer extends StatelessWidget {
  static const double cardRotateAngle = 4 / 180 * pi;
  static const double holoPadding = 15.0;
  static const double holoRadius = 12.0;
  final String title;
  final String content;
  final String desc;

  const QuizResultContainer({super.key, required this.title, required this.content, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 128),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: IntrinsicHeight(
                    child: Stack(
                      children: [
                        Transform.rotate(
                          angle: cardRotateAngle,
                          child: ClipPath(
                            clipper: RotateHoleClipper(
                              left: holoPadding,
                              top: holoPadding,
                              radius: holoRadius,
                              angle: cardRotateAngle,
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ClipPath(
                            clipper: HoleClipper(
                              left: holoPadding,
                              top: holoPadding,
                              radius: holoRadius,
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 90),
                                  Text(
                                    // 'Avoidant Attachment',
                                    title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      height: 21.5 / 18,
                                      color: Color(0xFFC981FF),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // const SizedBox(height: 4),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Image.asset(
                                        'assets/images/icons/ic_quotation_left.png',
                                        height: 18,
                                        width: 22,
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0, -14),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: Text(
                                        content,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 28 / 16,
                                          color: DreamerColors.grey800,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0, -14),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: Image.asset(
                                          'assets/images/icons/ic_quotation_right.png',
                                          height: 18,
                                          width: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15 + 7,
                  child: Transform.rotate(
                    origin: const Offset(0, 0),
                    angle: -6 * pi / 180,
                    child: const TextCard(text: 'CHARACTERISTICS'),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-56, -33),
                  child: Transform.rotate(
                    angle: 42 / 180 * pi,
                    child: const OvalRing(
                      width: 100,
                      height: 56,
                      // #F46BDB, #FFB9F2
                      colors: [Color(0xFFf46bdb), Color(0xFFffb9f2)],
                      strokeWidth: 3,
                    ),
                  ),
                ),
                // cover the up of ring
                Positioned(
                  left: 15,
                  top: 0,
                  child: ClipPath(
                    clipper: HoleClipper(
                      left: 0,
                      top: 15,
                      radius: 12,
                    ),
                    child: Container(
                      width: 12 * 2 - 2,
                      height: 15 + 4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 52),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 20.8 / 16,
                  color: DreamerColors.grey800,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: DreamerColors.primary.withOpacity(0.3),
                  decorationThickness: 6,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            )
          ],
        ));
  }
}

class TextCard extends StatelessWidget {
  final String text;

  const TextCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HoleClipper(
        left: 4,
        top: 4,
        radius: 6,
      ),
      child: Container(
        // 从上到下渐变颜色 #D6B0FF #943DF2
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFD6B0FF), Color(0xFF943DF2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 13,
              height: 15.5 / 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class OvalRingPainter extends CustomPainter {
  final double strokeWidth;
  final List<Color> colors;

  OvalRingPainter({required this.strokeWidth, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // final a = width / 2;
    // final b = a * sqrt(1 - pow(eccentricity, 2));

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );

    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class OvalRing extends StatelessWidget {
  final double width;
  final double height;
  final List<Color> colors;
  final double strokeWidth;

  const OvalRing({
    super.key,
    required this.width,
    required this.height,
    required this.colors,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: OvalRingPainter(colors: colors, strokeWidth: strokeWidth),
    );
  }
}

void main() {
  runApp(const MaterialApp(
      home: QuizResultPage(
    title: 'Avoidant Attachment',
    content: 'You are a person who is independent and self-sufficient. You are not afraid of being alone and you are not afraid of being abandoned. You are not afraid of being alone and you are not afraid of being abandoned. You are not afraid of being alone and you are not afraid of being abandoned.',
    desc: 'You are kind ，just you might need more love and more secure. In the future，someone will give you enough security.',
  )));
}
