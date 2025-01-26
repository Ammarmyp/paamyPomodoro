import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/components/custom_btn.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/utils/theme.dart';

class FocusScreen extends StatelessWidget {
  FocusScreen({super.key});

  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Mode'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => (timerController.isRunning.value ||
                    timerController.isPaused.value)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(timerController.remainingTime.value),
                        ),

                        //controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: timerController.stopTimer,
                              child: Text("Cancel"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: timerController.isPaused.value
                                  ? timerController.startTimer
                                  : timerController.pauseTimer,
                              child: Text(timerController.isRunning.value
                                  ? "Pause"
                                  : "Resume"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Timer Display
                      Obx(() => TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formatTime(
                                      timerController.remainingTime.value),
                                  style: TextStyle(
                                    fontSize: 55,
                                    letterSpacing: 4,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
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

                      CustomBtn(
                        onPressed: () => timerController.startTimer,
                        label: "Start",
                        width: 100,
                        borderRadius: 10,
                        textColor: AppTheme.gluonGrey,
                      ),
                      const SizedBox(height: 20),

                      // Focus Time Slider
                      const Text("Set Focus Time (minutes):"),
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

                      // Control Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => ElevatedButton(
                              onPressed: timerController.isRunning.value
                                  ? null
                                  : timerController.startTimer,
                              child: const Text("Start"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Obx(
                            () => ElevatedButton(
                              onPressed: !timerController.isRunning.value
                                  ? null
                                  : timerController.pauseTimer,
                              child: Text("Pause"),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: timerController.resetTimer,
                            child: Text("Reset"),
                          ),
                        ],
                      ),
                    ],
                  ),
          )),
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, "0");
    final secs = (seconds % 60).toString().padLeft(2, "0");
    return "$minutes:$secs";
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
