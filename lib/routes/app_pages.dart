import 'package:get/get.dart';
import 'package:train_booking_app/pages/authentication/login_page.dart';
import 'package:train_booking_app/pages/authentication/register_page.dart';
import 'package:train_booking_app/pages/booking_history_page.dart';
import 'package:train_booking_app/pages/confirm_booking_page.dart';
import 'package:train_booking_app/pages/final_booking_page.dart';
import 'package:train_booking_app/pages/home_page.dart';
import 'package:train_booking_app/pages/main_page.dart';
import 'package:train_booking_app/pages/payment_page.dart';
import 'package:train_booking_app/pages/splash_screen.dart';
import 'package:train_booking_app/pages/ticket_page.dart';
import 'package:train_booking_app/pages/train_seat_selection.dart';
import 'package:train_booking_app/routes/app_routes.dart';

class AppPages {
  static const loginIn = AppRoutes.loginPage;
  static const homePage = AppRoutes.homePage;
  static const mainPage = AppRoutes.mainPage;
  static final pageList = [
    GetPage(
      name: AppRoutes.signupPage,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.mainPage,
      page: () => const MainPage(),
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
    GetPage(
      name: AppRoutes.finalBookingPage,
      page: () => const FinalBookingPage(),
    ),
    GetPage(
      name: AppRoutes.bookingHistoryPage,
      page: () => const BookingHistoryPage(),
    ),
  ];
}
