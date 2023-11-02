import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/model/booking/schedule_model.dart';
import 'package:train_booking_app/services/booking_service.dart';
import 'package:train_booking_app/services/schedule_service.dart';
import 'package:train_booking_app/util/preference.dart';

class ScheduleController extends GetxController {
  List<ScheduleModel> scheduleList = <ScheduleModel>[].obs;
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController paxController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isLoading = true;
  int? bookingID;

  List<dynamic> seatList = [].obs;
  List<dynamic> coachList = [].obs;
  List<dynamic> tempSeatID = [].obs;
  List<dynamic> tempSeatName = [].obs;

  int? userID = Preference.getInt(Preference.userID);

  Future getTrainSchedule(
      String origin, String destination, String date) async {
    List response =
        await ScheduleService().getTrainSchedule(origin, destination, date);
    scheduleList =
        response.map((item) => ScheduleModel.fromJson(item)).toList();
    print(date);
    isLoading = false;
    update();
  }

  Future getSeat(int? coachId) async {
    seatList = await ScheduleService().getSeat(coachId);
    // scheduleList =
    //     response.map((item) => ScheduleModel.fromJson(item)).toList();
    // isLoading = false;
    // print(seatList);
    isLoading = false;
    update();
  }

  Future getCoach(int? trainID) async {
    coachList = await ScheduleService().getCoach(trainID);
    // scheduleList =
    //     response.map((item) => ScheduleModel.fromJson(item)).toList();
    isLoading = false;
    update();
  }

  Future createBooking(int? scheduleID, String totalPrice) async {
    var dataTemp =
        await BookingService().createBooking(scheduleID, userID, totalPrice);
    bookingID = dataTemp[0]['bookingID'];

    tempSeatID.toSet();

    for (int i = 0; i < tempSeatID.length; i++) {
      await BookingService().createBookingDetails(bookingID, tempSeatID[i]);
      await BookingService().updateSeatDetails(tempSeatID[i]);
    }
    isLoading = false;
    update();
  }

  Future getBookingHistory(int? scheduleID) async {
    isLoading = false;
    update();
  }
}
