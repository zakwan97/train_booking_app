class Booking {
  String bookingID;
  int scheduleID;
  final String userID;
  final DateTime createdAt;

  Booking({
    required this.bookingID,
    required this.scheduleID,
    required this.userID,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingID: json['bookingID'],
      scheduleID: json['scheduleID'],
      userID: json['userID'],
      createdAt: json['createdAt'],
      // coaches: (json['coaches'] as List<dynamic>)
      //     .map((coachData) => Coach.fromJson(coachData))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    // Convert the Train object to a JSON representation
    return {
      'bookingID': bookingID,
      'scheduleID': scheduleID,
      'userID': userID,
      'createdAt': createdAt
      // 'coaches': coaches.map((coach) => coach.toJson()).toList(),
    };
  }
}

class BookingModel {
  int bookingID;

  BookingModel({
    required this.bookingID,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingID': bookingID,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingID: json['bookingID'],
    );
  }
}
