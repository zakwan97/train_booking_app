import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:train_booking_app/helper/pdf_helper.dart';
import 'package:train_booking_app/model/booking/booking_history_model.dart';
import 'package:train_booking_app/model/user/user_model.dart';

class PDFBookingTicket {
  static Future<File> generate(
      UserModel usermodel, ScheduleModel schdeduleModel) async {
    final pdf = pw.Document();

    final iconImage = (await rootBundle.load('assets/images/train_image.png'))
        .buffer
        .asUint8List();

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 50,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.max,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Confirmation Booking',
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Train Ticket',
                      style: const pw.TextStyle(
                        fontSize: 15.0,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                // pw.Spacer(),
                // pw.Column(
                //   mainAxisSize: pw.MainAxisSize.min,
                //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                //   children: [
                //     pw.Text(
                //       usermodel.fullname,
                //       style: pw.TextStyle(
                //         fontSize: 15.5,
                //         fontWeight: pw.FontWeight.bold,
                //       ),
                //     ),
                //     pw.Text(
                //       usermodel.email,
                //     ),
                //     pw.Text(
                //       DateTime.now().toString(),
                //     ),
                //   ],
                // ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'Trip',
              style: pw.TextStyle(
                fontSize: 14.0,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              '${schdeduleModel.departureStation} to ${schdeduleModel.arrivalStation}',
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            // Table section
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
              },
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
              data: <List<String>>[
                <String>['Passenger', 'Seat'],
                <String>['John Doe', '12A'],
                <String>['Jane Doe', '14B'],
              ],
            ),
          ];
        },
      ),
    );
    return await PdfHelper.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
