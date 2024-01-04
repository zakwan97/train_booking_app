import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final authClient = Get.find<SupabaseClient>();

  //register
  Future signUpUser(String fullname, String email, String password) async {
    final user = await authClient.auth.signUp(email: email, password: password);
    final response = await authClient.from('Users').insert([
      {"fullname": fullname, "email": email, "password": password}
    ]);
    // if (response.error == null) {
    //   return user;
    // }
    return user;
  }

  //login user
  Future signIn(String email, String password) async {
    final user = await authClient.auth
        .signInWithPassword(email: email, password: password);

    return user;
  }

  //get current
  User getCurrentUser() {
    return authClient.auth.currentUser!;
  }

  //logOut user
  Future logOut() async {
    Get.find<GetStorage>().remove('user');
    await authClient.auth.signOut();
  }

//RecoverSession
  Future recoverSession(String session) async {
    return await authClient.auth.recoverSession(session);
  }
}
