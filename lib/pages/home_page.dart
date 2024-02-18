import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:train_booking_app/controller/navigation_controller.dart';
import 'package:train_booking_app/controller/login_controller.dart';
import 'package:train_booking_app/controller/schedule_controller.dart';
import 'package:train_booking_app/shared/keyboard_unfocus.dart';
import 'package:train_booking_app/shared/size_shared.dart';
import 'package:train_booking_app/shared/textformfield_shared_2.dart';
import 'package:train_booking_app/shared/uppercase_shared.dart';
import 'package:train_booking_app/util/preference.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchformKey = GlobalKey<FormState>();
  UserController u = Get.put(UserController());
  ScheduleController s = Get.put(ScheduleController());
  NavigationController nav = Get.put(NavigationController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    u.getData();
    super.initState();
  }

  toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  void changeValues() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      String temp = s.originController.text;
      s.originController.text = s.destinationController.text;
      s.destinationController.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (uc) {
      return SafeArea(
        top: false,
        child: KeyboardUnfocusFunction(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white10,
            appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                'assets/images/speedy_2.png',
                width: 50.w,
                height: 13.h,
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
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              elevation: 1.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Train Tickets",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    Stack(
                                      children: [
                                        Column(
                                          children: [
                                            TextFormFieldShared(
                                                inputFormatters: [
                                                  UpperCaseTextFormatter()
                                                ],
                                                controller: s.originController,
                                                keyboardType:
                                                    TextInputType.text,
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
                                                inputFormatters: [
                                                  UpperCaseTextFormatter()
                                                ],
                                                controller:
                                                    s.destinationController,
                                                keyboardType:
                                                    TextInputType.text,
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
                                          ],
                                        ),
                                        Positioned(
                                          top: 30,
                                          right: 10,
                                          child: Card(
                                            color: Colors.white,
                                            surfaceTintColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                side: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                            child: IconButton(
                                              color: Colors.red,
                                              iconSize: 25.0,
                                              onPressed: changeValues,
                                              icon: const Icon(
                                                  Icons.swap_vert_rounded),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    TextFormFieldShared(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: s.paxController,
                                        keyboardType: TextInputType.number,
                                        prefixIcon: Icons.people,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter your No of Pax';
                                          } else if (int.parse(value) > 3) {
                                            return 'Must not exceed 3 pax';
                                          }
                                          return null;
                                        },
                                        label: "No. of Pax",
                                        hintText: "",
                                        readOnly: false,
                                        obscureText: false,
                                        lines: 1),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    TextFormFieldShared(
                                        controller: s.dateController,
                                        keyboardType: TextInputType.datetime,
                                        prefixIcon: Icons.calendar_month,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter your Date';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2024-12-31'))
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
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      height: 45.0,
                                      color: Colors.red,
                                      minWidth: double.infinity,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Search Train",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
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
                            SizedBox(
                              height: 3.0.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "What's new",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Card(
                                      color: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.red,
                                              child: const Text("Test"),
                                            ),
                                            SvgPicture.asset(
                                              'assets/images/svg/coin.svg',
                                              semanticsLabel: 'My SVG Image',
                                              height: 80,
                                              width: 70,
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
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

  Widget drawer() {
    return SizedBox(
      width: 60.w,
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              drawerListTile(
                  title: 'Booking History',
                  onTap: () async {
                    // Get.toNamed('/bookingHistoryPage')!.then((value) {
                    //   Get.offAndToNamed('/homePage');
                    // });
                    Get.back();
                    Get.toNamed('/bookingHistoryPage');
                  },
                  icon: Icons.history),
              drawerListTile(
                  title: 'Logout',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return logoutDialog();
                      },
                    );
                  },
                  icon: Icons.logout_rounded),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerListTile(
      {required String title,
      required void Function()? onTap,
      required IconData? icon}) {
    return ListTile(
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            Text(title.tr),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

Widget logoutDialog() {
  return AlertDialog(
    title: const Text('Logout'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Are you sure want to logout?'),
        SizedBox(height: Height.sizedbox_height_20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Preference.setBool(Preference.isLogin, false);
                Preference.remove(Preference.userID);

                Get.offAllNamed('/loginPage');
              },
              child: const Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('No'),
            ),
          ],
        ),
      ],
    ),
  );
}
