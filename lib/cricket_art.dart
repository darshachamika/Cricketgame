import 'dart:math'; // pi is used to rotate the bat and ball seam.
import 'package:flutter/material.dart'; // Canvas, Paint and CustomPainter.

// Draws the two illustrations without downloaded images or extra packages.
class CricketArt extends CustomPainter {
  const CricketArt({required this.isBat});

  final bool isBat; // true draws a bat; false draws a ball.

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save(); // Remember the original canvas transformation.
    canvas.scale(size.width / 120, size.height / 120);
    // Use a fixed 120-by-120 coordinate system for both drawings.
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 120, 120),
      Paint()..color = Colors.white,
    );
    canvas.translate(60, 60); // Put the origin in the middle of the square.

    if (isBat) {
      canvas.rotate(pi / 4); // Tilt the upright bat by 45 degrees.
      final outline = Paint()
        ..color = const Color(0xFF35445F)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      const handle = Rect.fromLTWH(-5, -69, 10, 43);
      canvas.drawRect(handle, Paint()..color = const Color(0xFF8C9EBE));
      canvas.drawRect(handle, outline);
      // Round the corners of the wooden blade.
      final blade = RRect.fromRectAndRadius(
        const Rect.fromLTWH(-15, -27, 30, 91),
        const Radius.circular(4),
      );
      canvas.drawRRect(blade, Paint()..color = const Color(0xFFF1CA91));
      canvas.drawRRect(blade, outline);
    } else {
      canvas.drawCircle(
        Offset.zero,
        56,
        Paint()..color = const Color(0xFFFF3B30),
      );
      canvas.rotate(-pi / 4); // Angle the stitched seam across the ball.
      final seam = Paint()
        ..color = Colors.white
        ..strokeWidth = 1.6;
      canvas.drawLine(const Offset(-52, 0), const Offset(52, 0), seam);
      // Three rows of short stitches on each side of the central seam.
      for (final double y in [-10.0, -6.0, -3.0, 3.0, 6.0, 10.0]) {
        for (double x = -49; x < 49; x += 5) {
          canvas.drawLine(Offset(x, y), Offset(x + 2, y + 1), seam);
        }
      }
    }
    canvas.restore(); // Do not affect any later canvas drawing.
  }

  // Redraw only when the requested illustration changes.
  @override
  bool shouldRepaint(covariant CricketArt oldDelegate) {
    return oldDelegate.isBat != isBat;
  }
}
