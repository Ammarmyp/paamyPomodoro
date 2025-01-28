import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';

class DailyGoal extends StatelessWidget {
  DailyGoal({super.key});

  final goalController = TextEditingController();
  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Set your daily goal 🎯",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    final input = int.tryParse(goalController.text);
                    if (input != null && input > 0) {
                      timerController.setDailyGoal(input);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(3),
                    alignment: Alignment.center,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ),
                  child: Icon(
                    LucideIcons.plus,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: goalController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Enter time in minutes",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
