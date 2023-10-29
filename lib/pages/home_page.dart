import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/shared/keyboard_unfocus.dart';
import 'package:train_booking_app/shared/textformfield_shared_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController paxController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _searchformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: KeyboardUnfocusFunction(
        child: Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
            title: const Text(
              "HOMEPAGE",
              style: TextStyle(color: Colors.white, letterSpacing: 2.0),
            ),
            backgroundColor: Colors.red,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _searchformKey,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormFieldShared(
                            controller: originController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your Origin';
                              }
                              return null;
                            },
                            label: "Origin",
                            hintText: "",
                            prefixIcon: Icons.location_pin,
                            readOnly: false,
                            obscureText: false),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        TextFormFieldShared(
                            controller: paxController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your Destination';
                              }
                              return null;
                            },
                            label: "Destination",
                            hintText: "",
                            prefixIcon: Icons.location_pin,
                            readOnly: false,
                            obscureText: false),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: TextFormFieldShared(
                                  controller: dateController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter your No of Pax';
                                    }
                                    return null;
                                  },
                                  label: "No. of Pax",
                                  hintText: "",
                                  readOnly: false,
                                  obscureText: false,
                                  lines: 1),
                            ),
                            SizedBox(
                              width: 1.0.w,
                            ),
                            Flexible(
                              child: TextFormFieldShared(
                                  controller: originController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter your Date';
                                    }
                                    return null;
                                  },
                                  label: "Date",
                                  hintText: "",
                                  readOnly: true,
                                  obscureText: false,
                                  lines: 1),
                            ),
                          ],
                        ),
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
                          child: const Text("SEARCH"),
                          onPressed: () {
                            // if (_searchformKey.currentState!.validate()) {}
                            Get.toNamed('/ticketPage');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
