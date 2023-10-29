import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/route_manager.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/model/user/user_model.dart';
import 'package:train_booking_app/services/supabase_client.dart' as s;
import 'package:train_booking_app/shared/keyboard_unfocus.dart';
import 'package:train_booking_app/shared/size_shared.dart';
import 'package:train_booking_app/shared/textformfield_shared_2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  late String finalEmail;
  late String finalPassword;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  late SupabaseClient supabase;

  @override
  void initState() {
    supabase = SupabaseClient(
      s.supabaseUrl,
      s.supabaseApiKey,
    );
    super.initState();
  }

  Future<void> loginUser(String email, String password) async {
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
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardUnfocusFunction(
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   title: const Text("LOGIN"),
          //   titleSpacing: 1.5,
          // ),
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: Height.sizedbox_height_10),
                    child: Image.asset(
                      'assets/images/train_image.png',
                      width: 26.6.w,
                      height: 12.3.h,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormFieldShared(
                            controller: emailTextController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill in your email';
                              }
                              return null;
                            },
                            label: "Email",
                            hintText: "",
                            prefixIcon: Icons.email_rounded,
                            readOnly: false,
                            obscureText: false),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        TextFormFieldShared(
                            controller: passwordTextController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill in your password';
                              }
                              return null;
                            },
                            label: "Password",
                            hintText: "",
                            prefixIcon: Icons.key,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordTextController.text.isNotEmpty) {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  }
                                  print(_passwordVisible);
                                },
                                icon: _passwordVisible
                                    ? PhosphorIcon(PhosphorIcons.regular.eye)
                                    : PhosphorIcon(
                                        PhosphorIcons.regular.eyeClosed)),
                            readOnly: false,
                            obscureText: _passwordVisible ? false : true,
                            onChanged: (value) {},
                            lines: 1),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: 40.0,
                          color: Colors.red,
                          minWidth: double.infinity,
                          child: const Text("LOGIN"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                finalEmail = emailTextController.text;
                                finalPassword = passwordTextController.text;
                              });
                              await loginUser(finalEmail, finalPassword)
                                  .then((value) {
                                Get.offNamed('/homePage');
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
