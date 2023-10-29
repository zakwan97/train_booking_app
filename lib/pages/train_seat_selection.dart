import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

class TrainSeatSelectionPage extends StatefulWidget {
  const TrainSeatSelectionPage({super.key});

  @override
  State<TrainSeatSelectionPage> createState() => _TrainSeatSelectionPageState();
}

class _TrainSeatSelectionPageState extends State<TrainSeatSelectionPage> {
  // Constants for the number of coaches and seats per coach
  static const int numCoaches = 6;
  static const int seatsPerCoach = 20;

  // Constants to define seat number ranges for each coach
  static const List<int> coachSeatRanges = [20, 20, 20, 20, 20, 20];

  // State variables to track selected seats
  List<List<bool>> selectedSeats = List.generate(
    numCoaches,
    (coachIndex) => List.generate(
      seatsPerCoach,
      (seatIndex) => false,
    ),
  );

  int currentPage = 0;
  int paxCount = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Train Seat Selection'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CoachIndicator(
              numCoaches: numCoaches,
              currentPage: currentPage,
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Text(
              'Pax Count: $paxCount', // Display pax count
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: numCoaches,
                controller: PageController(),
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, coachIndex) {
                  return CoachSeatSelection(
                    coachNumber: coachIndex + 1,
                    selectedSeats: selectedSeats[coachIndex],
                    allowedSeatRange: coachSeatRanges[coachIndex],
                    onSeatSelected: (seatIndex) {
                      setState(() {
                        selectedSeats[coachIndex][seatIndex] =
                            !selectedSeats[coachIndex][seatIndex];
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/paymentPage');
              },
              child: const Text('Book Seats'),
            ),
          ],
        ),
      ),
    );
  }
}

class CoachSeatSelection extends StatelessWidget {
  final int coachNumber;
  final List<bool> selectedSeats;
  final int allowedSeatRange;
  final Function(int) onSeatSelected;

  const CoachSeatSelection({
    super.key,
    required this.coachNumber,
    required this.selectedSeats,
    required this.allowedSeatRange,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Coach $coachNumber',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'FRONT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.amber,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
              itemCount: selectedSeats.length,
              itemBuilder: (context, seatIndex) {
                return SeatWidget(
                  seatNumber: seatIndex + 1,
                  isSelected: selectedSeats[seatIndex],
                  onTap: () {
                    if (seatIndex < allowedSeatRange) {
                      onSeatSelected(seatIndex);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SeatWidget extends StatelessWidget {
  final int seatNumber;
  final bool isSelected;
  final Function onTap;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColor = isSelected ? Colors.green : Colors.blue;

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: seatColor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            seatNumber.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CoachIndicator extends StatelessWidget {
  final int numCoaches;
  final int currentPage;

  const CoachIndicator({
    super.key,
    required this.numCoaches,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numCoaches, (index) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }
}
