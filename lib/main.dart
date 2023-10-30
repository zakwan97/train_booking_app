import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/routes/app_pages.dart';
import 'package:train_booking_app/util/preference.dart';
import 'package:train_booking_app/util/supabase_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.init();
  supabaseclient;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (BuildContext context, Orientation orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/loginPage',
          getPages: AppPages.pageList,
        );
      },
    );
  }
}
