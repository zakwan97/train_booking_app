class Booking {
  final String id;
  final String userId;
  final String trainId;
  final String coachNumber;
  final List<String> numberOfPax;
  final DateTime timestamp;

  Booking({
    required this.id,
    required this.userId,
    required this.trainId,
    required this.coachNumber,
    required this.numberOfPax,
    required this.timestamp,
  });
}
