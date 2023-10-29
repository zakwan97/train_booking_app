import 'package:flutter/material.dart';

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
