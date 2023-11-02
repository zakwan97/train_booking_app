import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/controller/booking_controller.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({super.key});

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  BookingController bk = Get.put(BookingController());

  @override
  void initState() {
    bk.getBookingDHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            'BOOKING HISTORY',
            style: TextStyle(
                fontSize: 16, color: Colors.white, letterSpacing: 2.0),
          ),
        ),
        body: Card(
          elevation: 2.0,
          color: Colors.red[50],
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
