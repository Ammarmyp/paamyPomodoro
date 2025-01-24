import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paamy_pomodorro/controllers/navigation_controller.dart';
import 'package:paamy_pomodorro/controllers/task_controller.dart';
import 'package:paamy_pomodorro/controllers/theme_controller.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/pages/focus_screen.dart';
import 'package:paamy_pomodorro/pages/task_screen.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ThemeController themeController = Get.find<ThemeController>();
  final TimerController timerController = Get.find<TimerController>();
  final TaskController taskController = Get.find<TaskController>();
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          // Render the screen based on the current index
          return getSelectedScreen(index: navController.currentIndex.value);
        }),
        bottomNavigationBar: Obx(() {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BottomNavigationBar(
                currentIndex: navController.currentIndex.value,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surface,
                unselectedItemColor: Theme.of(context).colorScheme.onSurface,
                elevation: 0,
                onTap: (index) {
                  navController.currentIndex.value = index;
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(LucideIcons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(LucideIcons.hourglass),
                    label: "Focus",
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget getSelectedScreen({required int index}) {
    switch (index) {
      case 0:
        return TaskScreen();
      case 1:
        return FocusScreen();
      default:
        return const Center(
          child: Text("Page not found"),
        );
    }
  }
}
