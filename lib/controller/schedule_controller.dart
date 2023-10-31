import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/model/booking/schedule_model.dart';
import 'package:train_booking_app/services/schedule_service.dart';

class ScheduleController extends GetxController {
  List<ScheduleModel> scheduleList = <ScheduleModel>[].obs;
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController paxController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isLoading = true;

  List<dynamic> seatList = [].obs;
  List<dynamic> coachList = [].obs;

  Future getTrainSchedule(
      String origin, String destination, String date) async {
    List response =
        await ScheduleService().getTrainSchedule(origin, destination, date);
    scheduleList =
        response.map((item) => ScheduleModel.fromJson(item)).toList();
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
}
