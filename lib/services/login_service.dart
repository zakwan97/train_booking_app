import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/util/preference.dart';
import 'package:train_booking_app/util/supabase_client.dart';

class UserService {
  SupabaseClient supabase = supabaseclient;
  int? userID = Preference.getInt(Preference.userID);

  Future loginUser(String email, String password) async {
    final response = await supabase
        .from('Users')
        .select()
        .eq('email', email)
        .eq('password', password)
        .execute();
    // print(response.data[0]);
    // final responseData = jsonDecode(response.data);

    return response.data;
  }

  Future getUserDetails() async {
    final response =
        await supabase.from('Users').select().eq('userID', userID).execute();
    return response.data;
  }
}
