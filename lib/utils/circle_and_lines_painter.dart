import 'dart:math';
import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';

class CircleAndLinesPainter extends CustomPainter {
  const CircleAndLinesPainter({
    this.hasCircleOnly = false,
  });

  final bool hasCircleOnly;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = primaryColor;
    canvas.drawCircle(
        Offset(size.width / 2, size.width / 2), size.width / 2, paint);

    if (hasCircleOnly) return;

    double heightOffset = size.width + 8;
    while (heightOffset < size.height) {
      canvas.drawRect(
          Rect.fromPoints(
            Offset(size.width / 2 - 0.5, heightOffset),
            Offset(size.width / 2 + 0.5, min(heightOffset + 16, size.height)),
          ),
          paint);
      heightOffset += 24;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}