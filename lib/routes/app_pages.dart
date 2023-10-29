import 'package:get/get.dart';
import 'package:train_booking_app/pages/authentication/login_page.dart';
import 'package:train_booking_app/pages/confirm_booking_page.dart';
import 'package:train_booking_app/pages/home_page.dart';
import 'package:train_booking_app/pages/payment_page.dart';
import 'package:train_booking_app/pages/ticket_page.dart';
import 'package:train_booking_app/pages/train_seat_selection.dart';
import 'package:train_booking_app/routes/app_routes.dart';

class AppPages {
  static const loginIn = AppRoutes.loginPage;
  static final pageList = [
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.ticketPage,
      page: () => const TicketPage(),
    ),
    GetPage(
      name: AppRoutes.trainSeatSelectionPage,
      page: () => const TrainSeatSelectionPage(),
    ),
    GetPage(
      name: AppRoutes.confirmBookingPage,
      page: () => const ConfirmBookingPage(),
    ),
    GetPage(
      name: AppRoutes.paymentPage,
      page: () => const PaymentPage(),
    ),
  ];
}
