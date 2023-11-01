import 'package:get/get.dart';
import 'package:train_booking_app/services/booking_service.dart';
import 'package:train_booking_app/util/preference.dart';

class BookingController extends GetxController {
  bool isLoading = true;
  int? userID = Preference.getInt(Preference.userID);
  int? bookingID;

  void createBooking(int? scheduleID) async {
    var dataTemp = await BookingService().createBooking(scheduleID, userID);
    isLoading = false;
    print(dataTemp);
    update();
  }

  void createBookingDetail(int? seatID) async {
    await BookingService().createBookingDetails(bookingID, seatID);
    isLoading = false;
    // print(dataTemp);
    update();
  }
}
