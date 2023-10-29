import 'package:train_booking_app/model/train/seat_model.dart';

class Coach {
  int? coachId;
  String coachName;
  List<Seats> seat;

  Coach({this.coachId, required this.coachName, required this.seat});
}
