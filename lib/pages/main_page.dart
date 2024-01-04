import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/controller/navigation_controller.dart';
import 'package:train_booking_app/pages/booking_history_page.dart';
import 'package:train_booking_app/pages/bottomnavbar/animated_bottom_bar.dart';
import 'package:train_booking_app/pages/home_page.dart';
import 'package:train_booking_app/pages/profile/profile_page.dart';
import 'package:train_booking_app/shared/keyboard_unfocus.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      _scaffoldKey.currentState?.openDrawer();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return SafeArea(
        top: false,
        child: KeyboardUnfocusFunction(
          child: Scaffold(
            key: _scaffoldKey,
            extendBody: true,
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   title: const Text(
            //     "HOMEPAGE",
            //     style: TextStyle(color: Colors.white, letterSpacing: 2.0),
            //   ),
            //   backgroundColor: Colors.red,
            // ),
            bottomNavigationBar: AnimatedBottomBar(
              currentIndex: controller.currentIndex,
              icons: controller.icon,
              onTap: (int index) {
                print(index);
                setState(() {
                  controller.indexChange(index);
                });
              },
            ),
            body: IndexedStack(
              index: controller.currentIndex,
              children: const [HomePage(), BookingHistoryPage(), ProfilePage()],
            ),
          ),
        ),
      );
    });
  }
}
