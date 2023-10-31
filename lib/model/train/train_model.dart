import 'package:train_booking_app/model/train/coach_model.dart';

class Train {
  int? trainID;
  String trainNumber;
  String trainName;
  // List<Coach> coaches;

  Train({
    this.trainID,
    required this.trainNumber,
    required this.trainName,
    // required this.coaches,
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      trainID: json['trainID'],
      trainNumber: json['trainNumber'],
      trainName: json['trainName'],
      // coaches: (json['coaches'] as List<dynamic>)
      //     .map((coachData) => Coach.fromJson(coachData))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    // Convert the Train object to a JSON representation
    return {
      'trainID': trainID,
      'trainNumber': trainNumber,
      'trainName': trainName,
      // 'coaches': coaches.map((coach) => coach.toJson()).toList(),
    };
  }
}
