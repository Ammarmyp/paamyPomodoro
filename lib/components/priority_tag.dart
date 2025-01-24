import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paamy_pomodorro/utils/priority_colors.dart';

class PriorityTag extends StatelessWidget {
  final String priority;
  const PriorityTag({
    super.key,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return priority.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: getPriorityColor(priority, context),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  LucideIcons.flag,
                  size: 13,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 5),
                Text(
                  priority,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
