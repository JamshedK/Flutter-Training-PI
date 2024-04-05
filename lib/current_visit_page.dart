import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/_themed_app_bar.dart';
import 'package:tutorial/current_visit_data.dart';

// TODO: What are "unusual line terminators?" Should we care? - Daniel

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
            'Shelly completed your triage and you are assigned a Triage Level 3 (Click here to see what that means)\nEstimated Wait Time is 60 minutes.'),
    CurrentVisitData(
        timeOfEvent: '2:35pm',
        eventDescription:
            'An order for Abdominal X-ray has been placed and blood work has been requested.'),
    CurrentVisitData(
        timeOfEvent: '2:40pm',
        eventDescription:
            'Eric with Xray just signed up to come take you to get your Xray - He will be with you momentarily.'),
    CurrentVisitData(
        timeOfEvent: '2:45pm',
        eventDescription:
            'Steve with lab will be by to take you for a blood draw - This will happen right after your X-ray.'),
    CurrentVisitData(
        timeOfEvent: '3:30pm',
        eventDescription:
            'Your X-ray has been read by the radiologist Dr. Smith - We are working hard to get you into an ER Room.'),
    CurrentVisitData(
        timeOfEvent: '3:45pm', eventDescription: 'Your blood work is back.'),
    CurrentVisitData(
        timeOfEvent: '3:50pm',
        eventDescription:
            'A room just opened up and your Nurse will be Cheyenne, she or the tech will be out to pick you up and take you to your room.'),
    CurrentVisitData(
        timeOfEvent: '4:00pm',
        eventDescription:
            'Dr. Sinek just signed up and will be here soon. He is finshing up on some other patients. Please press your call out if you need your Nurse Cheyenne or your Tech.'),
    CurrentVisitData(
        timeOfEvent: '4:15pm',
        eventDescription:
            'The doctor has ordered some pain meds and your nurse will be bringing them shortly.'),
    CurrentVisitData(
        timeOfEvent: '5:00pm',
        eventDescription:
            'We are glad you are feeling better. Your discharge orders as well as a work note has been printed. Your nurse will bring them in soon. Please feel free to ask any questions.'),
    CurrentVisitData(
        timeOfEvent: '5:30pm',
        eventDescription:
            'We thank you for your visit today at Smith Health. Your care team was Cheyenne RN and Dr. Sinek. We hope we took excellent care of you or your loved one today. Please feel free to rate us on a scale of 0-10 where 10 is excellent. Don\'t forget to follow up with your Primary Care Provider and find your results from today\'s visit on your MyChart (Link to MyChart)'),
  ];
  const CurrentVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: 'Current Visit',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              for (var i = 0; i < _currentVisits.length; ++i)
                CurrentVisitEvent(
                    data: _currentVisits[i],
                    isLastEvent: i == _currentVisits.length - 1)
            ],
          ),
        ),
      ),
    );
  }
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
