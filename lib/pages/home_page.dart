import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:train_booking_app/controller/navigation_controller.dart';
import 'package:train_booking_app/controller/login_controller.dart';
import 'package:train_booking_app/controller/schedule_controller.dart';
import 'package:train_booking_app/pages/bottomnavbar/animated_bottom_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (uc) {
      return SafeArea(
        top: false,
        child: KeyboardUnfocusFunction(
          child: Scaffold(
            key: _scaffoldKey,
            // drawer: drawer(),
            backgroundColor: Colors.white,
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerFloat,
            // floatingActionButton: AnimatedBottomBar(
            //   currentIcon: hm.currentIndex,
            //   onTap: (int index) {
            //     setState(() {
            //       hm.indexChange(index);
            //     });
            //   },
            //   icons: hm.icon,
            // ),
            // bottomNavigationBar: AnimatedBottomBar(
            //   currentIndex: nav.currentIndex,
            //   icons: hm.icon,
            //   onTap: (int index) {
            //     print(index);
            //     setState(() {
            //       hm.indexChange(index);
            //     });
            //   },
            // ),
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
                              elevation: 2.0,
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
                                        inputFormatters: [
                                          UpperCaseTextFormatter()
                                        ],
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
                                        inputFormatters: [
                                          UpperCaseTextFormatter()
                                        ],
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
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              controller: s.paxController,
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please Enter your No of Pax';
                                                } else if (int.parse(value) >
                                                    3) {
                                                  return 'Must not exceed 3 pax';
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
            )
          ],
        ),
      ],
    ),
  );
}
