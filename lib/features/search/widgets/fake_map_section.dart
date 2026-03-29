import 'package:flutter/material.dart';

class FakeMapSection extends StatelessWidget {
  const FakeMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 245,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/map_placeholder.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xffEDEDED),
                    child: CustomPaint(
                      painter: _FakeMapPainter(),
                    ),
                  );
                },
              ),
            ),
            const Positioned(
              top: 42,
              left: 28,
              child: _MapPin(),
            ),
            const Positioned(
              top: 62,
              right: 58,
              child: _MapPin(),
            ),
            const Positioned(
              bottom: 52,
              left: 102,
              child: _MapPin(),
            ),
            const Positioned(
              bottom: 34,
              right: 42,
              child: _MapPin(),
            ),
            Positioned(
              left: 120,
              top: 94,
              child: Transform.rotate(
                angle: -0.35,
                child: const Icon(
                  Icons.navigation,
                  size: 22,
                  color: Color(0xffFF4D6D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.location_on_rounded,
      size: 26,
      color: Color(0xff4B3AC7),
    );
  }
}

class _FakeMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xffEFEFEF);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final roadPaint = Paint()
      ..color = const Color(0xffD7D7D7)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final thinRoadPaint = Paint()
      ..color = const Color(0xffDCDCDC)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final riverPaint = Paint()
      ..color = const Color(0xffCFCFCF)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final riverPath = Path()
      ..moveTo(-20, 120)
      ..quadraticBezierTo(70, 80, 150, 125)
      ..quadraticBezierTo(220, 170, size.width + 20, 135);

    canvas.drawPath(riverPath, riverPaint);

    final road1 = Path()
      ..moveTo(0, 60)
      ..quadraticBezierTo(90, 110, 170, 70)
      ..quadraticBezierTo(230, 35, size.width, 55);

    final road2 = Path()
      ..moveTo(20, 180)
      ..quadraticBezierTo(100, 130, 180, 165)
      ..quadraticBezierTo(240, 190, size.width, 170);

    final road3 = Path()
      ..moveTo(55, 0)
      ..quadraticBezierTo(85, 80, 110, 160)
      ..quadraticBezierTo(130, 210, 150, size.height);

    final road4 = Path()
      ..moveTo(size.width - 70, 0)
      ..quadraticBezierTo(size.width - 85, 75, size.width - 65, 145)
      ..quadraticBezierTo(size.width - 45, 200, size.width - 25, size.height);

    canvas.drawPath(road1, roadPaint);
    canvas.drawPath(road2, roadPaint);
    canvas.drawPath(road3, thinRoadPaint);
    canvas.drawPath(road4, thinRoadPaint);

    final textStyle = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 9,
      fontWeight: FontWeight.w500,
    );

    _drawText(canvas, 'East\nRutherford', const Offset(52, 18), textStyle);
    _drawText(canvas, 'Hackensack\nMeadowlands\nConservation\nand Wildlife Area',
        Offset(size.width - 95, 35), textStyle);
    _drawText(canvas, 'Secaucus', const Offset(118, 142), textStyle);
    _drawText(canvas, 'Union City', Offset(size.width - 62, 160), textStyle);
    _drawText(canvas, 'Rutherford', const Offset(10, 70), textStyle);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    TextStyle style,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 4,
    )..layout(maxWidth: 120);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}