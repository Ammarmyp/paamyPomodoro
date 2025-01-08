import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/controllers/theme_controller.dart';

class ThemeToggler extends StatelessWidget {
  ThemeToggler({super.key});

  final ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => themeController.toggleTheme(),
      child: Obx(() {
        return Icon(
          themeController.themeMode.value == ThemeMode.dark
              ? Icons.dark_mode
              : Icons.light_mode,
        );
      }),
    );
  }
}
