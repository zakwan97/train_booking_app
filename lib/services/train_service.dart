import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/util/supabase_client.dart';

class TrainService {
  SupabaseClient supabase = supabaseclient;

  Future getTrainSchedule(
      String origin, String destination, String date) async {
    final response = await supabase
        .from('Schedule')
        .select()
        .eq('origin', origin)
        .eq('destination', destination)
        .eq('date', date)
        .execute();
    print(response.data[0]);
    // final responseData = jsonDecode(response.data);

    return response.data;
  }
}
