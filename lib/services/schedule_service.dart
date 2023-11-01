import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/util/supabase_client.dart';

class ScheduleService {
  SupabaseClient supabase = supabaseclient;

  Future getTrainSchedule(
      String origin, String destination, String date) async {
    // final response = await supabase
    //     .from('Schedule')
    //     .select()
    //     .eq('origin', origin)
    //     .eq('destination', destination)
    //     .execute();

    DateTime dateTime = DateFormat("MMMM dd, yyyy").parse(date);
    String formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);

    final response = await supabase
        .from('Schedule')
        .select(
            'scheduleID, trainID, departureStation, arrivalStation, departureTime, arrivalTime,'
            'departureDate, price, arrivalDate, origin, destination, price, date, Train(trainID, trainNumber, trainName)')
        .eq('origin', origin)
        .eq('destination', destination)
        .eq('date', formattedDate);
    // print(response);
    return response;
  }

  Future getSeat(int? coachId) async {
    // final response = await supabase
    //     .from('Schedule')
    //     .select()
    //     .eq('origin', origin)
    //     .eq('destination', destination)
    //     .execute();

    final response = await supabase
        .from('Seats')
        .select('*')
        .eq('coachID', coachId)
        .order('seatID', ascending: true);

    return response;
  }

  Future getCoach(int? trainID) async {
    // final response = await supabase
    //     .from('Schedule')
    //     .select()
    //     .eq('origin', origin)
    //     .eq('destination', destination)
    //     .execute();

    // final response = await supabase.from('Coach').select('*').eq('coachID', coachId);
    final response = await supabase
        .from('Train_Coach')
        .select('*, Coach(coachID, coachNumber)')
        .eq('trainID', trainID);
    // print(response);
    return response;
  }
}
