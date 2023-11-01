import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:train_booking_app/controller/login_controller.dart';
import 'package:train_booking_app/controller/schedule_controller.dart';
import 'package:train_booking_app/shared/keyboard_unfocus.dart';
import 'package:train_booking_app/shared/textformfield_shared_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextEditingController originController = TextEditingController();
  // TextEditingController destinationController = TextEditingController();
  // TextEditingController paxController = TextEditingController();
  // TextEditingController dateController = TextEditingController();
  final _searchformKey = GlobalKey<FormState>();
  UserController u = Get.find();
  ScheduleController s = Get.put(ScheduleController());

  @override
  void initState() {
    u.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (uc) {
      return SafeArea(
        top: false,
        child: KeyboardUnfocusFunction(
          child: Scaffold(
            backgroundColor: Colors.red[50],
            appBar: AppBar(
              title: const Text(
                "HOMEPAGE",
                style: TextStyle(color: Colors.white, letterSpacing: 2.0),
              ),
              backgroundColor: Colors.red,
            ),
            body: uc.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _searchformKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text("Welcome ${uc.userData!.fullname}!"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text("Where do you want to go?"),
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    TextFormFieldShared(
                                        controller: s.originController,
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
                                        controller: s.destinationController,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          child: TextFormFieldShared(
                                              controller: s.paxController,
                                              keyboardType:
                                                  TextInputType.number,
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
                                              controller: s.dateController,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please Enter your Date';
                                                }
                                                return null;
                                              },
                                              onTap: () {
                                                showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime.now(),
                                                        lastDate:
                                                            DateTime.parse(
                                                                '2023-11-08'))
                                                    .then(
                                                  (value) {
                                                    if (value != null) {
                                                      setState(() {
                                                        s.dateController.text =
                                                            DateFormat.yMMMMd()
                                                                .format(value);
                                                      });
                                                    } else {
                                                      s.dateController.text =
                                                          s.dateController.text;
                                                    }
                                                  },
                                                ).catchError(
                                                  (error) {
                                                    s.dateController.clear();
                                                  },
                                                );
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      height: 40.0,
                                      color: Colors.red,
                                      minWidth: double.infinity,
                                      child: const Text("SEARCH"),
                                      onPressed: () {
                                        if (_searchformKey.currentState!
                                            .validate()) {
                                          s
                                              .getTrainSchedule(
                                                  s.originController.text,
                                                  s.destinationController.text,
                                                  s.dateController.text)
                                              .then((value) {
                                            Get.toNamed('/ticketPage');
                                          });
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
