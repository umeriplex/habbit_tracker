import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/ui/home/page_flip_builder.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:hive/hive.dart';
import '../../models/task.dart';
import '../../presistance/hive_data_store.dart';

class HomePage extends ConsumerWidget {

  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return PageFlipBuilder(
      key: _pageFlipKey,
      frontBuilder: (_) => ValueListenableBuilder(
        valueListenable: dataStore.frontTasksListenable(),
        builder: (_, Box<Task> box,__){
          return TasksGridPage(
            tasks: box.values.toList(),
            onFlip: (){
              _pageFlipKey.currentState?.flip();
            },
          );
        },
      ),

















      backBuilder: (_) => ValueListenableBuilder(
        valueListenable: dataStore.frontTasksListenable(),
        builder: (_, Box<Task> box,__){
          return TasksGridPage(
              tasks: box.values.toList(),
              onFlip: (){
                _pageFlipKey.currentState?.flip();
              },
          );
        },
      ),
    );
  }
}
