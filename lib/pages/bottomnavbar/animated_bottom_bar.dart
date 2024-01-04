import 'package:flutter/material.dart';
import 'package:train_booking_app/model/icon_model.dart';

class AnimatedBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<IconModel> icons;
  final ValueChanged<int>? onTap;
  const AnimatedBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: icons
            .map(
              (icon) => GestureDetector(
                onTap: () => onTap?.call(icon.index),
                child: AnimatedSize(
                    curve: Curves.decelerate,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon.icon,
                          size: currentIndex == icon.index ? 30 : 23,
                          color: currentIndex == icon.index
                              ? Colors.red
                              : Colors.blueGrey,
                        ),
                        Text(
                          icon.title,
                          style: TextStyle(
                            fontSize: 10,
                            color: currentIndex == icon.index
                                ? Colors.red
                                : Colors.blueGrey,
                          ),
                        )
                      ],
                    )),
              ),
            )
            .toList(),
      ),
    );
  }
}
