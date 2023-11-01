import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/controller/schedule_controller.dart';
import 'package:train_booking_app/shared/keyboard_unfocus.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  ScheduleController s = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: KeyboardUnfocusFunction(
        child: Scaffold(
          backgroundColor: Colors.red[50],
          appBar: AppBar(
            title: const Text(
              "SELECT DEPART TICKET",
              style: TextStyle(
                  fontSize: 16, color: Colors.white, letterSpacing: 2.0),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Origin: ${s.originController.text}"),
                              Text(
                                  "Destination: ${s.destinationController.text}"),
                              Text("Date: ${s.dateController.text}"),
                              Text("No of Pax: ${s.paxController.text}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.0.h),
                    (s.scheduleList.isEmpty)
                        ? const Text('No Ticket Found')
                        : Flexible(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: s.scheduleList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ListTile(
                                          isThreeLine: true,
                                          title: Text(s.scheduleList[index]
                                              .train.trainName),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  'Train From: ${s.scheduleList[index].departureStation} to ${s.scheduleList[index].arrivalStation}'),
                                              Text(
                                                  'Price: RM${s.scheduleList[index].price}'),
                                            ],
                                          ),
                                          onTap: () async {
                                            await s
                                                .getCoach(s.scheduleList[index]
                                                    .trainID)
                                                .then((value) async {
                                              print(s
                                                  .scheduleList[index].trainID);
                                              await s.getSeat(
                                                  s.coachList[0]['coachID']);
                                            }).then((value) {
                                              print(s
                                                  .scheduleList[index].trainID);
                                              Get.toNamed(
                                                      'trainSeatSelectionPage')!
                                                  .then((value) {
                                                print(value);
                                                if (value == null) {
                                                  s.getSeat(s.coachList[0]
                                                      ['coachID']);
                                                }
                                              });
                                            });
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
