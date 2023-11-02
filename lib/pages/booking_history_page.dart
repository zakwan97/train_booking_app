import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
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
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Full Name: ${historyItem.users.fullname}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Departure Station: ${historyItem.schedule.departureStation}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Arrival Station: ${historyItem.schedule.arrivalStation}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Departure Time: ${historyItem.schedule.departureTime}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Arrival Time: ${historyItem.schedule.arrivalTime}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Departure Date: ${historyItem.schedule.departureDate}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Arrival Date: ${historyItem.schedule.arrivalDate}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Price: RM${historyItem.totalPrice}',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          );
        },
      ),
    );

    // Get the directory for saving the PDF file (cross-platform)
    final dir = await getApplicationDocumentsDirectory();

    // Ensure the directory exists
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    // Generate the PDF file name
    final fileName = 'booking_history_$index.pdf';

    // Create the file path
    final filePath = '${dir.path}/$fileName';

    // Save the PDF to the specified file path
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
  }
}
