import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';

import '../../models/task_preset.dart';
import '../theming/app_theme.dart';
import 'animated_tasks.dart';

class TasksWithName extends StatelessWidget {
  const TasksWithName({Key? key, required this.task}) : super(key: key);
  final TaskPreset task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedTask(
            iconName: task.iconName,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          task.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyles.taskName.copyWith(
            color: AppTheme.of(context).accent,
          ),
        ),
      ],
    );
  }
}
