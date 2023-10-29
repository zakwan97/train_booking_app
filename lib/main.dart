import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://hwmbhsmwgtzsccdccadb.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3bWJoc213Z3R6c2NjZGNjYWRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyOTkwMTAsImV4cCI6MjAxMzg3NTAxMH0.U9cIWHqUZxTZ1w1Vt1j6orS8FPKuQHknRjbiVE5JkN8');
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
