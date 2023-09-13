import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import '../../models/task.dart';
import 'home_page_bottom_options.dart';

class TasksGridPage extends StatelessWidget {
  const TasksGridPage({
    Key? key,
    required this.tasks,
    this.onFlip,
  }) : super(key: key);
  final List<Task> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: TasksGridContents(
          tasks: tasks,
          onFlip: onFlip,
        ),
      ),
    );
  }
}

class TasksGridContents extends StatelessWidget {
  const TasksGridContents({
    Key? key,
    required this.tasks,
    this.onFlip,
  }) : super(key: key);
  final List<Task> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: TasksGrid(
              tasks: tasks,
            ),
          ),
        ),
        HomePageBottomOptions(
          onFlip: onFlip,
        ),
      ],
    );
  }
}

