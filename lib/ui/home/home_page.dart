import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import '../tasks/animated_tasks.dart';
import '../tasks/tasks_compl_ring.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: Center(
        child: SizedBox(
          width: 240,
          child: AnimatedTask(
            iconName: AppAssets.phone,
          )
        ),
      ),
    );
  }
}
