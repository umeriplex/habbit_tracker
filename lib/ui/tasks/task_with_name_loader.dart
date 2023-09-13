import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:habit_tracker_flutter/ui/tasks/task_with_name.dart';
import 'package:hive/hive.dart';
import '../../models/task.dart';
import '../../presistance/hive_data_store.dart';

class TaskWithNameLoader extends ConsumerWidget {
  final Task task;
  const TaskWithNameLoader({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.taskStateListenable(task: task),
      builder: (context, Box<TaskState> box, _) {
        final taskState = dataStore.taskState(box, task: task);
        return TasksWithName(
          task: task,
          isCompleted: taskState.isCompleted,
          onComplete: (completed) {
            ref.read(dataStoreProvider).setTaskState(task: task, completed: completed);
          },
        );
      },
    );
  }
}
