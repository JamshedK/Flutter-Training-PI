import 'package:flutter/material.dart';
import 'package:patient_inform/pages/visits.dart';
import 'package:patient_inform/widgets/themed_app_bar.dart';

class PastVisitsPage extends StatelessWidget {
  const PastVisitsPage({super.key});

  final _items = const [
    PastVisit(
      visitData: VisitData(
        date: "15 July 2023",
        reasonForVisit: "Knee fracture, bad back pain",
        medications: "Surgery of knee, painkillers",
        timeSpent: "2 hrs 45 minutes",
      ),
    ),
    PastVisit(
      visitData: VisitData(
        date: "10 June 2023",
        reasonForVisit: "Heart attack",
        medications: "Aspirin",
        timeSpent: "1 hr 30 minutes",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ThemedAppBar(
          title: 'Past Visits History',
          context: context,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: 16,
            ),
            itemCount: _items.length,
            itemBuilder: (_, index) => _items[index],
          ),
        ));
  }
}