import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final String seatNumber;
  final bool isAvailable;
  final bool isSelected;
  final Function onTap;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.isAvailable,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColor = isAvailable
        ? isSelected
            ? Colors.green // Selected seat
            : Colors.blue // Available seat
        : Colors.grey; // Unavailable seat

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          onTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: seatColor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            seatNumber,
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
