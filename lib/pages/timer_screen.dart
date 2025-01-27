import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/components/custom_btn.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/utils/format_time.dart';
import 'package:paamy_pomodorro/utils/progress_calculator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimerScreen extends StatelessWidget {
  TimerScreen({super.key});

  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CircularPercentIndicator(
              radius: 160,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Theme.of(context).colorScheme.surface,
              lineWidth: 10.0,

              // percent: 0.4,
              percent: calculateProgress(
                  timerController.remainingTime.value.toDouble(),
                  (timerController.focusTime.value * 60).toDouble()),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    formatTime(timerController.remainingTime.value),
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Full Screen",
                    ),
                  )
                ],
              ),
              progressColor: Color(Theme.of(context).colorScheme.primary.value),
            ),

            const SizedBox(
              height: 30,
            ),

            //controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBtn(
                  onPressed: timerController.stopTimer,
                  label: ("Cancel"),
                  textColor: Theme.of(context).colorScheme.onSurface,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
                CustomBtn(
                  onPressed: timerController.isPaused.value
                      ? timerController.startTimer
                      : timerController.pauseTimer,
                  label: (timerController.isRunning.value ? "Pause" : "Resume"),
                  textColor: Theme.of(context).colorScheme.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  elevation: 10,
                ),
                CustomBtn(
                    label: "Reset",
                    textColor: Theme.of(context).colorScheme.onSurface,
                    onPressed: timerController.isPaused.value
                        ? timerController.resetTimer
                        : null,
                    backgroundColor: Theme.of(context).colorScheme.surface),
              ],
            ),
          ],
        ));
  }
}
