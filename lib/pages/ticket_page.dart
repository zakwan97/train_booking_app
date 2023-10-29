import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/shared/keyboard_unfocus.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  int selectedIndex =
      DateTime.now().day - 1; // Initialize selectedIndex to today's date
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;

  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: KeyboardUnfocusFunction(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Select Depart Ticket",
              style: TextStyle(color: Colors.white, letterSpacing: 2.0),
            ),
            backgroundColor: Colors.red,
          ),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 2.0,
                        color: Colors.red[300],
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Origin: Kuala Lumpur"),
                              Text("Destination: Kota Bharu"),
                              Text("Date: 30/11/2023"),
                              Text("No of Pax: 1"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.0.h),
                    Flexible(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ListTile(
                                    title: Text('$index'),
                                    onTap: () {
                                      Get.toNamed('trainSeatSelectionPage');
                                    }, // Handle your onTap here.
                                  )),
                            );
                          }),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
