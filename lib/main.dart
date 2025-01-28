import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paamy_pomodorro/controllers/navigation_controller.dart';
import 'package:paamy_pomodorro/controllers/task_controller.dart';
import 'package:paamy_pomodorro/controllers/theme_controller.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/models/focus_session.dart';
import 'package:paamy_pomodorro/models/task_model.dart';
import 'package:paamy_pomodorro/pages/my_home_page.dart';
import 'package:paamy_pomodorro/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(FocusSessionAdapter());
  await Hive.openBox<TaskModel>('tasks');
  await Hive.openBox<FocusSession>('focusSession');
  await Hive.openBox<DailyStats>('dailyStats');
  await Hive.openBox('userGoal');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());
  final TimerController timerController = Get.put(TimerController());
  final TaskController taskController = Get.put(TaskController());
  final NavigationController navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
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
