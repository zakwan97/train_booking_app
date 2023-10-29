import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/services/supabase_client.dart' as source;

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final supabase = SupabaseClient(
      source.supabaseUrl,
      source.supabaseApiKey,
    );
  }
}
