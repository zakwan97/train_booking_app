import 'package:train_booking_app/model/train/coach_model.dart';

class Train {
  int? trainID;
  String trainNumber;
  String trainName;
  List<Coach> coaches;

  Train({
    this.trainID,
    required this.trainName,
    required this.trainNumber,
    required this.coaches,
  });
}
