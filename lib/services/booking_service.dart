import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/util/supabase_client.dart';

class BookingService {
  SupabaseClient supabase = supabaseclient;

  Future getBookingDetails(int? userID, int? scheduleID) async {
    final response = await supabase
        .from('Booking')
        .select('Users(fullname),'
            'Schedule(departureStation, arrivalStation, departureTime, arrivalTime, departureDate, arrivalDate, price)')
        .eq('userID', userID)
        .eq('scheduleID', scheduleID);
    print(response);
    return response;
  }

  Future createBooking(int? scheduleID, int? userID) async {
    DateTime dateNow = DateTime.now();
    String dateTimeString = dateNow.toIso8601String();
    var response = await supabase
        .from('Booking')
        .insert({
          'scheduleID': scheduleID,
          'userID': userID,
          // 'paymentType': paymentType,
          'created_at': dateTimeString
        })
        .select('bookingID')
        .execute();

    return response.data;
  }

  Future createBookingDetails(int? bookingId, int? seatID) async {
    DateTime dateNow = DateTime.now();
    String dateTimeString = dateNow.toIso8601String();
    final response = await supabase.from('Booking_Seat').insert({
      'bookingID': bookingId,
      'seatID': seatID,
      'created_at': dateTimeString
    });
    return response;
  }

  Future updateSeatDetails(
    int? seatID,
  ) async {
    final response = await supabase
        .from('Seats')
        .update({'isBooked': true})
        .eq('seatID', seatID)
        .execute();
    return response;
  }
}
