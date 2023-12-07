import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/controller/booking_controller.dart';

class FinalBookingPage extends StatefulWidget {
  const FinalBookingPage({super.key});

  @override
  State<FinalBookingPage> createState() => _FinalBookingPageState();
}

class _FinalBookingPageState extends State<FinalBookingPage> {
  BookingController bc = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('TICKET CONFIRMED'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Card(
                    child: Text('Success'),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Card(
                    child: Text('Please go to booking history to print'),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 40.0,
                    color: Colors.green,
                    minWidth: double.infinity,
                    child: const Text("FINISH"),
                    onPressed: () {
                      Get.offAllNamed('/homePage')!.then((value) {});
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
