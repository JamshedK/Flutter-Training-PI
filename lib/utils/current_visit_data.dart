class CurrentVisitData {
  const CurrentVisitData({
    required this.timeOfEvent,
    required this.eventDescription,
  });
  final String timeOfEvent;
  final String eventDescription;
}

// TODO: Do we need a PastVisitData? Or is this not necessary? - DY