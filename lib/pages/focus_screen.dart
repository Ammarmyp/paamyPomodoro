import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paamy_pomodorro/components/custom_btn.dart';
import 'package:paamy_pomodorro/controllers/stat_controller.dart';
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
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LucideIcons.info,
            ),
          )
        ],
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

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: timerController.customSessions
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            int minutes = entry.value;
                            double percentage = timerController.isRunning.value
                                ? timerController.remainingTime.value /
                                    (minutes * 60)
                                : 1.0;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (!timerController.isRunning.value) {
                                    timerController
                                        .updateTimerForSession(index);
                                  }
                                },
                                onLongPress: () =>
                                    timerController.removeCustomSession(index),
                                child: CircularPercentIndicator(
                                  radius: 35,
                                  percent: percentage > 1.0 ? 1.0 : percentage,
                                  progressColor: timerController
                                              .selectedSession.value ==
                                          index
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.2),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  animation: true,
                                  backgroundWidth: 3,
                                  lineWidth: 4,
                                  center: Text(
                                    "$minutes",
                                    style: TextStyle(
                                        color: timerController
                                                    .selectedSession.value ==
                                                index
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Focus sessions from the new list"),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: timerController.focusSessions
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            int minutes = entry.value.durationInMinutes;
                            double percentage = timerController.isRunning.value
                                ? timerController.remainingTime.value /
                                    (minutes * 60)
                                : 1.0;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => timerController
                                    .updateTimerForSession(index),
                                onLongPress: () =>
                                    timerController.removeCustomSession(index),
                                child: CircularPercentIndicator(
                                  radius: 35,
                                  percent: percentage > 1.0 ? 1.0 : percentage,
                                  progressColor: timerController
                                              .selectedSession.value ==
                                          index
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.2),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  animation: true,
                                  backgroundWidth: 3,
                                  lineWidth: 4,
                                  center: Text(
                                    "$minutes",
                                    style: TextStyle(
                                        color: timerController
                                                    .selectedSession.value ==
                                                index
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(40)),
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          child: Icon(
                            LucideIcons.plus,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onTap: () => _showAddSessionDialog(context),
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
        ),
      ),
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
                timerController.saveFocusSession(DateTime.now(), input);
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

  void _showAddSessionDialog(BuildContext context) {
    final TextEditingController _sessionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Focus Session"),
        content: TextField(
          controller: _sessionController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Enter minutes",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final int minutes = int.tryParse(_sessionController.text) ?? 0;
              if (minutes > 0) {
                timerController.addCustomSession(minutes);
                // timerController.saveFocusSession(DateTime.now(), minutes);
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}
