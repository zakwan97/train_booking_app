import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/util/preference.dart';
import 'package:train_booking_app/util/supabase_client.dart';

class BookingService {
  SupabaseClient supabase = supabaseclient;

  int? userID = Preference.getInt(Preference.userID);

  Future getBookingDetails(int? scheduleID, int? bookingID) async {
    int? id = userID;
    final response = await supabase
        .from('Booking_2')
        .select('Users(fullname),'
            'Schedule(departureStation, arrivalStation, departureTime, arrivalTime, departureDate, arrivalDate, price)')
        .eq('userID', id)
        .eq('scheduleID', scheduleID)
        .eq('bookingID', bookingID)
        .execute();
    print(response);
    return response.data;
  }

  Future getBookingHistory() async {
    int? id = userID;
    final response = await supabase
        .from('Booking_2')
        .select('totalPrice,'
            'Users(userID, fullname, email),'
            'Schedule(departureStation, arrivalStation, departureTime, arrivalTime, departureDate, arrivalDate, price)')
        .eq('userID', id);
    print(response);
    return response;
  }

  Future createBooking(int? scheduleID, int? userID, String totalPrice) async {
    DateTime dateNow = DateTime.now();
    String dateTimeString = dateNow.toIso8601String();
    var response = await supabase
        .from('Booking_2')
        .insert({
          'scheduleID': scheduleID,
          'userID': userID,
          'totalPrice': totalPrice,
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
