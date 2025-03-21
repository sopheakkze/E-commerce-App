import 'package:app/controllers/product_controller.dart';
import 'package:app/screen/wecome_screen.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize NavigationController globally
  Get.put(NavigationController());
  Get.lazyPut(() => ProductController());

  await Supabase.initialize(
    url: 'https://ffqjhpiyadzbfzjiobvn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZmcWpocGl5YWR6YmZ6amlvYnZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA0MTAzOTUsImV4cCI6MjA1NTk4NjM5NX0.UCwX-DxA0KTvDUR0HOMKH7C7rGJxBM4GySaBeFngQhc',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FLutter Demo',
      theme: lightMode,
      // home:  const ProductView(),
      // home:  const NavigationMenu(),
      home:  const WecomeScreen(),
      // home: const SettingScreen(),
    );
  }
}

