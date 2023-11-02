import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/controller/booking_controller.dart';
import 'package:pdf/widgets.dart' as pw;

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
    return GetBuilder<BookingController>(builder: (context) {
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
            child: Center(
              child: (bk.bkHistoryList.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: bk.bkHistoryList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ListTile(
                                    trailing: InkWell(
                                      onTap: () async {
                                        await extractToPDF(index);
                                      },
                                      child: const Icon(Icons.print),
                                    ),
                                    title: Text(
                                        'Full Name: ${bk.bkHistoryList[index].users.fullname}'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Departure Station: ${bk.bkHistoryList[index].schedule.departureStation}'),
                                        Text(
                                            'Arrival Station: ${bk.bkHistoryList[index].schedule.arrivalStation}'),
                                        Text(
                                            'Departure Time: ${bk.bkHistoryList[index].schedule.departureTime}'),
                                        Text(
                                            'Arrival Time: ${bk.bkHistoryList[index].schedule.arrivalTime}'),
                                        Text(
                                            'Departure Date: ${bk.bkHistoryList[index].schedule.departureDate}'),
                                        Text(
                                            'Arrival Date: ${bk.bkHistoryList[index].schedule.arrivalDate}'),
                                        Text(
                                            'Price: RM${bk.bkHistoryList[index].totalPrice}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> extractToPDF(int index) async {
    final pdf = pw.Document();
    final historyItem = bk.bkHistoryList[index];

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Full Name: ${historyItem.users.fullname}'),
              pw.Text(
                  'Departure Station: ${historyItem.schedule.departureStation}'),
              pw.Text(
                  'Arrival Station: ${historyItem.schedule.arrivalStation}'),
              pw.Text('Departure Time: ${historyItem.schedule.departureTime}'),
              pw.Text('Arrival Time: ${historyItem.schedule.arrivalTime}'),
              pw.Text('Departure Date: ${historyItem.schedule.departureDate}'),
              pw.Text('Arrival Date: ${historyItem.schedule.arrivalDate}'),
              pw.Text('Price: RM${historyItem.totalPrice}'),
            ],
          );
        },
      ),
    );

    final dir = Directory(
        '/path/to/save/pdf'); // Replace with the desired directory path
    final file = File('${dir.path}/booking_history_$index.pdf');
    await file.writeAsBytes(await pdf.save());

    // You can now use the generated PDF file (file.path) as needed.
  }
}
