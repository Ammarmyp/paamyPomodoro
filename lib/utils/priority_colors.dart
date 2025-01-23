import 'package:flutter/material.dart';

Color getPriorityColor(String priority, BuildContext context) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Theme.of(context).colorScheme.primary.withOpacity(0.55);
    case 'medium':
      return const Color(0xFF19B0F1).withOpacity(0.55);
    case 'low':
      return const Color(0xFF8C8C8C).withOpacity(0.55);
    default:
      return Theme.of(context).colorScheme.surface;
  }
}
