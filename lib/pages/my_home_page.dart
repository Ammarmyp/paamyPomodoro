import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/components/theme_toggler.dart';
import 'package:paamy_pomodorro/controllers/theme_controller.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({
    super.key,
  });
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ThemeToggler(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(themeController.theme == ThemeMode.dark ? "Dark" : "Light"),
            ThemeToggler()
          ],
        ),
      ),
    );
  }
}
