import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:hive/hive.dart';
import '../../models/task.dart';
import '../../presistance/hive_data_store.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.tasksListenable(),
      builder: (_, Box<Task> box,__){
        return TasksGridPage(
          tasks: box.values.toList()
        );
      },
    );
  }
}
