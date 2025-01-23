import 'package:flutter/material.dart';
import 'package:paamy_pomodorro/utils/theme.dart';

Color getPriorityColor(String priority, BuildContext context) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Theme.of(context).colorScheme.primary.withOpacity(0.55);
    case 'medium':
      return AppTheme.lightBlue.withOpacity(0.55);
    case 'low':
      return const Color(0xFF8C8C8C).withOpacity(0.55);
    default:
      return Theme.of(context).colorScheme.surface;
  }
}
