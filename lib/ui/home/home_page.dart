import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';

import '../../models/task_preset.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TasksGridPage(
      tasks: [
        TaskPreset(
            name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
        TaskPreset(name: 'Walk the Dog', iconName: AppAssets.dog),
        TaskPreset(name: 'Do Some Coding', iconName: AppAssets.html),
        TaskPreset(name: 'Meditate', iconName: AppAssets.meditation),
        TaskPreset(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
        TaskPreset(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
      ],
    );
  }
}
