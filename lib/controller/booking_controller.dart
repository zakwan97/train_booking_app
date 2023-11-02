import 'package:get/get.dart';
import 'package:train_booking_app/model/booking/booking_history_model.dart';
import 'package:train_booking_app/model/booking/schedule_model.dart' as s;
import 'package:train_booking_app/services/booking_service.dart';

class BookingController extends GetxController {
  String? trainName;
  String? departureDate;
  String? departureTime;
  String? arrivalDate;
  String? arrivalTime;
  double? price;
  late String pax;
  double? finalPrice;
  List? selectedSeat;
  List<s.ScheduleModel>? bkSchedule;

  List<BookingDetailsModel> bkHistoryList = <BookingDetailsModel>[].obs;

  bool isLoading = true;

  Future getBookingDetails(int? scheduleID, int? bookingID) async {
    List response =
        await BookingService().getBookingDetails(scheduleID, bookingID);
    bkHistoryList =
        response.map((item) => BookingDetailsModel.fromJson(item)).toList();
    update();
  }

  Future<void> getBookingDHistory() async {
    List response = await BookingService().getBookingHistory();
    bkHistoryList =
        response.map((item) => BookingDetailsModel.fromJson(item)).toList();
    update();
  }
}
