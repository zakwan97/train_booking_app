import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:train_booking_app/model/user/user_model.dart';
import 'package:train_booking_app/services/supabase_client.dart' as s;

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final supabase = SupabaseClient(
    s.supabaseUrl,
    s.supabaseApiKey,
  );

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      final email = emailTextController.text;
      final password = passwordTextController.text;

      // Query the Supabase database to fetch user details
      final response = await supabase
          .from('Users')
          .select()
          .eq('email', email)
          .eq('password', password)
          .execute();

      if (response.data.isNotEmpty) {
        final userData = response.data[0] as Map<String, dynamic>;
        final userModel = UserModel.fromJson(userData);

        print(userModel.userID);
        // User with the provided email and password exists
        // You can navigate to the home page or perform other actions here
        Get.offNamed('/homePage');
      } else {
        // User not found or password is incorrect
        // Handle the login error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill in your email';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordTextController,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill in your password';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: loginUser,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
