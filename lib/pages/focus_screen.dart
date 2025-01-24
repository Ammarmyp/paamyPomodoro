import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';

class FocusScreen extends StatelessWidget {
  FocusScreen({super.key});

  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pomodoro Timer')),
      body: Center(
        child: Obx(() {
          final minutes = (timerController.remainingTime.value ~/ 60)
              .toString()
              .padLeft(2, '0');
          final seconds = (timerController.remainingTime.value % 60)
              .toString()
              .padLeft(2, '0');

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$minutes:$seconds',
                style: TextStyle(fontSize: 48),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: timerController.isRunning.value
                        ? timerController.pauseTimer
                        : timerController.startTimer,
                    child: Text(
                        timerController.isRunning.value ? 'Pause' : 'Start'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: timerController.resetTimer,
                    child: Text('Reset'),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
