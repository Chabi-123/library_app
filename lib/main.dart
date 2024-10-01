import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/Controller/getX_controller.dart';
import 'package:library_app/class/class.dart';
import 'package:library_app/firebase_options.dart';
import 'package:library_app/pages/BottonNa.dart';
import 'package:library_app/pages/log%20In.dart';
import 'package:library_app/pages/payment.dart';
import 'package:library_app/pages/splish_screen.dart';
import 'package:provider/provider.dart';
 // Import your NewPage

Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ManageState()), // Add your ManageState provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Add your ThemeProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: ()=>splash()),
        GetPage(name: '/log_in', page: ()=>Login()),
        GetPage(name: '/nav_bar', page: ()=>PracticeBottomNavBar()),
        GetPage(name: '/PaymentPage', page: ()=>PaymentPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: Provider.of<ThemeProvider>(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // home: splash(), // Set NewPage as the home
    );
  }
}
