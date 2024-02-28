import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';

class CurrentVisitPage extends StatelessWidget {
  static const _currentVisits = [
    CurrentVisitData(
        timeOfEvent: '2:00pm',
        eventDescription: 'You have checked into the Smith Health ER'),
    CurrentVisitData(
        timeOfEvent: '2:15pm',
        eventDescription:
            'Your care starts soon, Shelly the ER Triage Nurse will be with you in just a moment. Be ready to answer some questions about your visit today. '),
    CurrentVisitData(
        timeOfEvent: '2:30pm',
        eventDescription:
            'Shelly completed your triage and you are assigned a Triage Level 3 (Click here to see what that means)\nEstimated Wait Time is 60 minutes'),
  ];
  const CurrentVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CurrentVisitEvent(data: _currentVisits[0]),
              CurrentVisitEvent(data: _currentVisits[1]),
              CurrentVisitEvent(
                data: _currentVisits[2],
                isLastEvent: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentVisitData {
  const CurrentVisitData({
    required this.timeOfEvent,
    required this.eventDescription,
  });
  final String timeOfEvent;
  final String eventDescription;
}

class CurrentVisitEvent extends StatelessWidget {
  const CurrentVisitEvent({
    super.key,
    required this.data,
    this.isLastEvent = false,
  });

  final CurrentVisitData data;
  final bool isLastEvent;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        // TODO: check if this is required after implementing
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomPaint(
            painter: _CircleAndLinesPainter(hasCircleOnly: isLastEvent),
            child: const SizedBox(width: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.timeOfEvent,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                Text(
                  data.eventDescription,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleAndLinesPainter extends CustomPainter {
  const _CircleAndLinesPainter({
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
            Offset(size.width / 2 - 1, heightOffset),
            Offset(size.width / 2 + 1, min(heightOffset + 16, size.height)),
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
