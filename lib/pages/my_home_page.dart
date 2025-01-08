import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:paamy_pomodorro/components/theme_toggler.dart';
import 'package:paamy_pomodorro/controllers/theme_controller.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/pages/task_screen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({
    super.key,
  });
  final ThemeController themeController = Get.find<ThemeController>();
  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pomodoro Timer"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ThemeToggler(),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Obx(() {
              return SleekCircularSlider(
                appearance: CircularSliderAppearance(),
                initialValue: timerController.remainingTime.value / 1500 * 100,
                onChangeEnd: (value) => timerController.updateTimer(),
                onChange: (value) {},
                innerWidget: (_) => Center(
                  child: Text(
                    "${(timerController.remainingTime.value ~/ 60).toString().padLeft(2, '0')}:${(timerController.remainingTime.value % 60).toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              );
            }),
          ),
        ),
        floatingActionButton: Obx(() {
          return FloatingActionButton(
            onPressed: () {
              timerController.isRunning.value
                  ? timerController.pauseTimer()
                  : timerController.startTimer();
            },
            child: Icon(
              timerController.isRunning.value ? Icons.pause : Icons.play_arrow,
            ),
          );
        }),
      ),
    );
  }
}
