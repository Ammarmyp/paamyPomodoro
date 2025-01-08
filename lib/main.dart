import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/controllers/theme_controller.dart';
import 'package:paamy_pomodorro/pages/my_home_page.dart';
import 'package:paamy_pomodorro/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.theme,
          home: MyHomePage(),
        );
      },
    );
  }
}
