import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libura/presentation/pages/home_page.dart';
import 'package:libura/utils/constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Libura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background),
      home: HomePage(),
    );
  }
}
