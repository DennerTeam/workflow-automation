import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_automation/backend/supabase/supabase.dart';
import 'package:workflow_automation/controller/login_controller.dart';
import 'package:workflow_automation/ui/pages/home_page.dart';
import 'package:workflow_automation/ui/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupaFlow.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Denner Workflow Automation',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: loginController.isLoggedIn.value ? HomePage() : LoginScreen(),
      ),
    );
  }
}
