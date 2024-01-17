import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:train_booking_app/controller/booking_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:train_booking_app/helper/pdf_helper.dart';
import 'package:train_booking_app/pages/pdf/booking_ticket_invoice.dart';

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
            centerTitle: true,
            backgroundColor: Colors.red,
            title: const Text(
              'BOOKING HISTORY',
              style: TextStyle(
                  fontSize: 16, color: Colors.white, letterSpacing: 2.0),
            ),
          ),
          body: Center(
              child: (bk.isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )
                  : (bk.bkHistoryList.isNotEmpty)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: bk.bkHistoryList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.red[50],
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ListTile(
                                        trailing: InkWell(
                                          onTap: () async {
                                            // await extractToPDF(index);
                                            // generate pdf file
                                            final pdfFile =
                                                await PDFBookingTicket.generate(
                                                    bk.bkHistoryList[index]
                                                        .users,
                                                    bk.bkHistoryList[index]
                                                        .schedule);
                                            // opening the pdf file
                                            PdfHelper.openFile(pdfFile);
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
                        )
                      : const Center(
                          child: Text('Empty'),
                        )),
        ),
      );
    });
  }

  Future<void> extractToPDF(int index) async {
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
    final historyItem = bk.bkHistoryList[index];
    var status = await Permission.storage.status;

    try {
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      print("dah lepas");

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            print("dah lepas build");
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Full Name: ${historyItem.users.fullname}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
                pw.Text(
                  'Departure Station: ${historyItem.schedule.departureStation}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
                pw.Text(
                  'Arrival Station: ${historyItem.schedule.arrivalStation}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
                pw.Text(
                  'Departure Time: ${historyItem.schedule.departureTime}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
                pw.Text(
                  'Arrival Time: ${historyItem.schedule.arrivalTime}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
                pw.Text(
                  'Departure Date: ${historyItem.schedule.departureDate}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
                pw.Text(
                  'Arrival Date: ${historyItem.schedule.arrivalDate}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
                pw.Text(
                  'Price: RM${historyItem.totalPrice}',
                  style: pw.TextStyle(font: ttf, fontSize: 10),
                ),
              ],
            );
          },
        ),
      );

      // Get the directory for saving the PDF file (cross-platform)
      final dir = await getApplicationDocumentsDirectory();
      print("dah lepas dir");
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
    } catch (ex) {
      Future.error(ex);
    }
  }
}
