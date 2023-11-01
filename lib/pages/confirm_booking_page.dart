import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/controller/schedule_controller.dart';
import 'package:train_booking_app/services/booking_service.dart';

class ConfirmBookingPage extends StatefulWidget {
  // final String trainName;
  // final String departureStation;
  // final String arrivalStation;
  // final String departureTime;
  // final String arrivalTime;
  // final double ticketPrice;
  // final int numberOfTickets;
  // Default value

  const ConfirmBookingPage({
    super.key,
    // required this.trainName,
    // required this.departureStation,
    // required this.arrivalStation,
    // required this.departureTime,
    // required this.arrivalTime,
    // required this.ticketPrice,
    // required this.numberOfTickets,
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

  ScheduleController s = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'BOOKING CONFIRMATION',
          style:
              TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 2.0),
        ),
      ),
      body: Card(
        elevation: 2.0,
        color: Colors.red[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Train Name: '),
              const Text('Departure Station: '),
              const Text('Arrival Station: '),
              const Text('Departure Time: '),
              const Text('Arrival Time: '),
              const Text('Ticket Price: RM'),
              const Text('Number of Tickets: '),
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
                  if (selectedPaymentMethod == 'Select Payment Method') {
                    // await s.createBooking(s.scheduleList[0].scheduleID);
                    BookingService().getBookingDetails(1, 1);
                  } else {}
                },
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
