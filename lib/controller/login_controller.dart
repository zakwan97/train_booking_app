import 'package:get/get.dart';
import 'package:train_booking_app/model/user/user_model.dart';
import 'package:train_booking_app/services/login_service.dart';
import 'package:train_booking_app/util/preference.dart';

class UserController extends GetxController {
  UserModel? userData;
  bool? isLoading = true;

  Future<void> checkSignIn(String email, String password) async {
    var userDataTemp = await UserService().loginUser(email, password);
    userData = UserModel.fromJson(userDataTemp[0]);
    Preference.setInt(Preference.userID, userData!.userID);
    // var newUserID = Preference.getInt(Preference.userID);
    update();
  }
}
