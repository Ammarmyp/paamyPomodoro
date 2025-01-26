import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/components/custom_btn.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/pages/timer_screen.dart';
import 'package:paamy_pomodorro/utils/format_time.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FocusScreen extends StatelessWidget {
  FocusScreen({super.key});

  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Focus Mode',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 20,
          ),
          child: SingleChildScrollView(
            child: Obx(
              () => (timerController.isRunning.value ||
                      timerController.isPaused.value)
                  ? TimerScreen()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        // Time Display
                        Obx(() => TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    formatTime(
                                        timerController.remainingTime.value),
                                    style: TextStyle(
                                      fontSize: 85,
                                      letterSpacing: 4,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  Text(
                                    "min",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () => _showTimeInputDialog(context),
                            )),
                        const SizedBox(height: 20),

                        Obx(
                          () => CustomBtn(
                            onPressed: timerController.isRunning.value
                                ? null
                                : timerController.startTimer,
                            label: "Start",
                            textColor: Theme.of(context).colorScheme.surface,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        //*Custom focus times in a row of circles

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentIndicator(
                              radius: 34,
                              percent: 0.1,
                              progressColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: true,
                              backgroundWidth: 4,
                              lineWidth: 5,
                              center: Text("10"),
                            ),
                            CircularPercentIndicator(
                              radius: 34,
                              percent: 0.81,
                              progressColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: true,
                              backgroundWidth: 4,
                              lineWidth: 5,
                              center: Text("10"),
                            ),
                            CircularPercentIndicator(
                              radius: 34,
                              percent: 0.51,
                              progressColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: true,
                              backgroundWidth: 4,
                              lineWidth: 5,
                              center: Text("10"),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        // Focus Time Slider
                        Obx(
                          () => Slider(
                            value: timerController.sliderValue.value.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 20,
                            label: "${timerController.sliderValue.value} min",
                            onChanged: (value) =>
                                timerController.updateSlider(value.toInt()),
                            onChangeEnd: (value) {
                              timerController.setFocusTime(value.toInt());
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
            ),
          )),
    );
  }

  /// Function to show a dialog for inputting focus time in minutes
  void _showTimeInputDialog(BuildContext context) {
    final TextEditingController timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Set Focus Time"),
        content: TextField(
          controller: timeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Enter time in minutes",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final input = int.tryParse(timeController.text);
              if (input != null && input > 0) {
                timerController.setFocusTime(input); // Update focus time
                Navigator.pop(context); // Close dialog
              } else {
                Get.snackbar(
                  "Invalid Input",
                  "Please enter a valid positive number",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text("Set"),
          ),
        ],
      ),
    );
  }
}
