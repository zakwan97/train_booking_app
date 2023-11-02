import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/controller/booking_controller.dart';
import 'package:train_booking_app/controller/schedule_controller.dart';
import 'package:train_booking_app/services/booking_service.dart';

class ConfirmBookingPage extends StatefulWidget {
  const ConfirmBookingPage({
    super.key,
  });

  @override
  _ConfirmBookingPageState createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  String? selectedPaymentMethod = 'Select Payment Method';
  List<String> paymentMethods = [
    'Select Payment Method',
    'Online Banking',
    'Credit Card',
  ];

  var bookingId = 0;
  late double totalPrice;
  BookingController bk = Get.find();
  ScheduleController s = Get.find();

  double calculateTotalPrice(String pax, double ticketPrice) {
    int numberOfTickets = int.tryParse(pax) ?? 0;

    totalPrice = numberOfTickets * ticketPrice;

    return totalPrice;
  }

  @override
  void initState() {
    calculateTotalPrice(bk.pax, bk.bkSchedule![0].price);
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
            'BOOKING CONFIRMATION',
            style: TextStyle(
                fontSize: 16, color: Colors.white, letterSpacing: 2.0),
          ),
        ),
        body: Card(
          elevation: 2.0,
          color: Colors.red[50],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Train Name: ${bk.bkSchedule![0].train.trainName}'),
                Text(
                    'Departure Station: ${bk.bkSchedule![0].departureStation}'),
                Text('Arrival Station: ${bk.bkSchedule![0].arrivalStation}'),
                Text('Date Departure: ${bk.bkSchedule![0].departureDate}'),
                Text('Departure Time: ${bk.bkSchedule![0].departureTime}'),
                Text('Arrival Time: ${bk.bkSchedule![0].arrivalTime}'),
                Text('Ticket Price: RM$totalPrice'),
                Text('Number of Tickets: ${bk.pax}'),
                DropdownButton<String>(
                  value: selectedPaymentMethod,
                  items: paymentMethods.map((String paymentMethod) {
                    return DropdownMenuItem<String>(
                      value: paymentMethod,
                      child: Text(paymentMethod),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    setState(() {
                      selectedPaymentMethod = newValue;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedPaymentMethod != 'Select Payment Method') {
                      await s
                          .createBooking(s.scheduleList[0].scheduleID,
                              totalPrice.toString())
                          .then((value) {
                        BookingService().getBookingDetails(
                            s.scheduleList[0].scheduleID, s.bookingID);
                      });
                      Get.offAllNamed('/finalBookingPage');
                    } else {
                      Get.snackbar('Payment', 'Please select your payment type',
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: const Text('Confirm Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
