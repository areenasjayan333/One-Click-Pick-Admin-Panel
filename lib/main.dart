import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_admin/main_screen.dart';
import 'package:shopping_admin/provider/VendorProvider.dart';
import 'package:shopping_admin/provider/bannerProvider.dart';
import 'package:shopping_admin/provider/categoryProvider.dart';
import 'package:shopping_admin/screen/banner_screen.dart';
import 'package:shopping_admin/screen/category_screen.dart';
import 'package:shopping_admin/screen/dashboard_screen.dart';
import 'package:shopping_admin/screen/order_screen.dart';
import 'package:shopping_admin/screen/vendor_screen.dart';
import 'package:shopping_admin/screen/withdrawal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyAJoSsG6IMYOMD8I8Sd30MZEVXDckZds_E",
              appId: "1:61360620004:web:c93da30c4aa17e5a4387f1",
              messagingSenderId: "61360620004",
              projectId: "shoppiee-b447f",
              storageBucket: "shoppiee-b447f.appspot.com",
            )
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => OfferBannerProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => VendorProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xff08192b),
          ),
          useMaterial3: true,
        ),
        home: const MainScreen(),
        routes: {
          DashBoardScreen.routename: (context) => DashBoardScreen(),
          OrderScreen.routename: (context) => OrderScreen(),
          VendorScreen.routename: (context) => VendorScreen(),
          WithdrawalScreen.routename: (context) => WithdrawalScreen(),
          BannerScreen.routename: (context) => BannerScreen(),
          CategoryScreen.routename: (context) => CategoryScreen()
        },
      ),
    );
  }
}
