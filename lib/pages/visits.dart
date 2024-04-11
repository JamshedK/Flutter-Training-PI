import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';

class VisitData {
  const VisitData({
    required this.date,
    required this.reasonForVisit,
    required this.timeSpent,
    required this.medications,
  });

  final String date;
  final String reasonForVisit;
  final String timeSpent;
  final String medications;
}

class PastVisit extends StatelessWidget {
  const PastVisit({
    super.key,
    required this.visitData,
  });

  final VisitData visitData;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black), // 0X33FFFFFF
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Visiting date",
                  style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0XFF494949),
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  visitData.date,
                  style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0XFF494949),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Reason",
              style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0XFF494949),
                  fontStyle: FontStyle.italic),
            ),
            Text(
              visitData.reasonForVisit,
              style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0XFF494949),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Medication",
              style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0XFF494949),
                  fontStyle: FontStyle.italic),
            ),
            Text(
              visitData.medications,
              style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0XFF494949),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Time spent",
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0XFF494949),
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        visitData.timeSpent,
                        style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0XFF494949),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 25, vertical: 0)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: const MaterialStatePropertyAll(primaryColor),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      child: const Text("View Details"))
                ],
              ),
            )
          ],
        ));
  }
}
