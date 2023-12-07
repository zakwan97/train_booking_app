import 'package:train_booking_app/model/user/user_model.dart';

class BookingDetailsModel {
  String totalPrice;
  UserModel users;
  ScheduleModel schedule;

  BookingDetailsModel({
    required this.totalPrice,
    required this.users,
    required this.schedule,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsModel(
      totalPrice: json['totalPrice'],
      users: UserModel.fromJson(json['Users']),
      schedule: ScheduleModel.fromJson(json['Schedule']),
    );
  }
}

// class UserModel {
//   String fullname;

//   UserModel({
//     required this.fullname,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       fullname: json['fullname'],
//     );
//   }
// }

class ScheduleModel {
  String departureStation;
  String arrivalStation;
  String departureTime;
  String arrivalTime;
  String departureDate;
  String arrivalDate;
  double price;

  ScheduleModel({
    required this.departureStation,
    required this.arrivalStation,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureDate,
    required this.arrivalDate,
    required this.price,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      departureStation: json['departureStation'],
      arrivalStation: json['arrivalStation'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      departureDate: json['departureDate'],
      arrivalDate: json['arrivalDate'],
      price: json['price'].toDouble(),
    );
  }
}
