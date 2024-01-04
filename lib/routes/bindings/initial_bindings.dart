import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/controller/login_controller.dart';
import 'package:train_booking_app/controller/navigation_controller.dart';
import 'package:train_booking_app/util/supabase_client.dart' as s;

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => SupabaseClient(s.supabaseUrl, s.supabaseApiKey),
        fenix: true);
    Get.put<NavigationController>(NavigationController(), permanent: true);
  }
}
