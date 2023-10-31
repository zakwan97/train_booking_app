import 'package:train_booking_app/model/train/train_model.dart';

class ScheduleModel {
  int scheduleID;
  int trainID;
  String departureStation;
  String arrivalStation;
  String departureTime;
  String arrivalTime;
  String departureDate;
  double price;
  String arrivalDate;
  String origin;
  String destination;
  String date;
  Train train;

  ScheduleModel({
    required this.scheduleID,
    required this.trainID,
    required this.departureStation,
    required this.arrivalStation,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureDate,
    required this.price,
    required this.arrivalDate,
    required this.origin,
    required this.destination,
    required this.date,
    required this.train,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleID: json['scheduleID'],
      trainID: json['trainID'],
      departureStation: json['departureStation'],
      arrivalStation: json['arrivalStation'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      departureDate: json['departureDate'],
      price: json['price'].toDouble(),
      arrivalDate: json['arrivalDate'],
      origin: json['origin'],
      destination: json['destination'],
      date: json['date'],
      train: Train.fromJson(json['Train']),
    );
  }
}
