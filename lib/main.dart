import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weu_cart_seller/views/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeuCart Seller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins',
        // useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
