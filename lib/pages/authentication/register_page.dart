import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/services/auth_service.dart';
import 'package:train_booking_app/shared/keyboard_unfocus.dart';
import 'package:train_booking_app/util/supabase_client.dart' as s;
import 'package:train_booking_app/shared/textformfield_shared_2.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService auth = AuthService();
  TextEditingController fnameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController cpasswordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _cpasswordVisible = false;

  late String ffName;
  late String fpassword;
  late String femail;

  late SupabaseClient supabase;

  @override
  void initState() {
    supabase = SupabaseClient(
      s.supabaseUrl,
      s.supabaseApiKey,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardUnfocusFunction(
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Register"),
            titleSpacing: 1.5,
          ),
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(50),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: const Color(0xFF000000).withAlpha(60),
                  //         blurRadius: 10.0,
                  //         spreadRadius: 0.0,
                  //         offset: const Offset(
                  //           0.0,
                  //           3.0,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Image.asset(
                  //     'assets/images/train_logo.png',
                  //     width: 40.w,
                  //     height: 20.h,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please Fill in your details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        TextFormFieldShared(
                            controller: fnameTextController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill in your full name';
                              }
                              return null;
                            },
                            label: "Name",
                            hintText: "",
                            prefixIcon: Icons.person_2,
                            readOnly: false,
                            obscureText: false),
                        SizedBox(
                          height: 1.0.h,
                        ),
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
                            prefixIcon: Icons.key_outlined,
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
                        TextFormFieldShared(
                            controller: cpasswordTextController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill in your password';
                              }
                              return null;
                            },
                            label: "Confirm Password",
                            hintText: "",
                            prefixIcon: Icons.key_outlined,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (cpasswordTextController.text.isNotEmpty) {
                                    setState(() {
                                      _cpasswordVisible = !_cpasswordVisible;
                                    });
                                  }
                                  print(_cpasswordVisible);
                                },
                                icon: _cpasswordVisible
                                    ? PhosphorIcon(PhosphorIcons.regular.eye)
                                    : PhosphorIcon(
                                        PhosphorIcons.regular.eyeClosed)),
                            readOnly: false,
                            obscureText: _cpasswordVisible ? false : true,
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
                          child: const Text("Register"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &
                                (passwordTextController.text ==
                                    cpasswordTextController.text)) {
                              setState(() {
                                ffName = fnameTextController.text;
                                femail = emailTextController.text;
                                fpassword = passwordTextController.text;
                              });
                              await auth.signUpUser(ffName, femail, fpassword);
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
