import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/model/icon_model.dart';
import 'package:train_booking_app/pages/booking_history_page.dart';
import 'package:train_booking_app/pages/home_page.dart';
import 'package:train_booking_app/pages/profile/profile_page.dart';

class NavigationController extends GetxController {
  // int currentIndex = const Icon(Icons.person).hashCode;
  int currentIndex = 0;
  List<IconModel> icon = [
    IconModel(index: 0, icon: Icons.home_outlined, title: "Home"),
    IconModel(index: 1, icon: Icons.list_rounded, title: "Booking"),
    IconModel(index: 2, icon: Icons.person_2_outlined, title: "Profile"),
  ];

  // List<IconModel> icon = [
  //   {1: const Icon(Icons.home_outlined)},
  //   {2: const Icon(Icons.history_outlined)},
  //   {3: const Icon(Icons.person_2_outlined)},
  // ];

  void indexChange(int index) {
    currentIndex = index;
    update();
  }

  List<Widget> widgetPage = <Widget>[
    const HomePage(),
    const BookingHistoryPage(),
    const ProfilePage()
  ];
}
