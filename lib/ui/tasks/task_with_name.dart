import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';
import '../../models/task.dart';
import '../theming/app_theme.dart';
import 'animated_tasks.dart';

class TasksWithName extends StatelessWidget {
  const TasksWithName({Key? key, required this.task, this.isCompleted = false, this.onComplete}) : super(key: key);
  final Task task;
  final bool isCompleted;
  final ValueChanged<bool>? onComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedTask(
            iconName: task.iconName,
            isCompleted: isCompleted,
            onComplete: onComplete,

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
