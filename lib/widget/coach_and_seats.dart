import 'package:flutter/material.dart';

class CoachSeatSelection extends StatelessWidget {
  final int coachNumber;
  final List<bool> selectedSeats;
  final Function(int) onSeatSelected;

  const CoachSeatSelection({
    super.key,
    required this.coachNumber,
    required this.selectedSeats,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Coach $coachNumber',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5.0, // Add vertical gap between rows
                crossAxisSpacing: 16.0),
            itemCount: selectedSeats.length,
            itemBuilder: (context, seatIndex) {
              return SeatWidget(
                seatNumber: seatIndex + 1,
                isSelected: selectedSeats[seatIndex],
                onTap: () {
                  onSeatSelected(seatIndex);
                },
              );
            },
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
