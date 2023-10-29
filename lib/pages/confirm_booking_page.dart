import 'package:flutter/material.dart';

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
  final String selectedPaymentMethod = 'Select Payment Method';
  List<String> paymentMethods = [
    'Select Payment Method',
    'Bank Transfer',
    'Credit Card',
    'PayPal',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Train Name: '),
            const Text('Departure Station: '),
            const Text('Arrival Station: '),
            const Text('Departure Time: '),
            const Text('Arrival Time: '),
            const Text('Ticket Price: \$}'),
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
                setState(() {});
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the confirmation and proceed with the booking,
                // taking into account the selected payment method.
                if (selectedPaymentMethod == 'Select Payment Method') {
                  // Show an error message or prevent the user from proceeding without selecting a payment method.
                } else {
                  // Proceed with the booking based on the selected payment method.
                  // You can navigate to the payment page or perform any other action.
                }
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
