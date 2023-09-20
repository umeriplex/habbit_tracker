import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/ui/home/page_flip_builder.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:hive/hive.dart';
import '../../models/task.dart';
import '../../presistance/hive_data_store.dart';
import '../sliding_panel/sliding_panel_animator.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();
  final _frontPageLeftSlidingAnimatorKey = GlobalKey<SlidingPanelAnimatorState>();
  final _frontPageRightSlidingAnimatorKey = GlobalKey<SlidingPanelAnimatorState>();
  final _backPageLeftSlidingAnimatorKey = GlobalKey<SlidingPanelAnimatorState>();
  final _backPageRightSlidingAnimatorKey = GlobalKey<SlidingPanelAnimatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __){
        final dataStore = ref.watch(dataStoreProvider);
        return PageFlipBuilder(
          key: _pageFlipKey,
          frontBuilder: (_) => ValueListenableBuilder(
            valueListenable: dataStore.frontTasksListenable(),
            builder: (_, Box<Task> box,__){
              return TasksGridPage(
                key: ValueKey(1),
                tasks: box.values.toList(),
                onFlip: (){
                  _pageFlipKey.currentState?.flip();
                },
                leftAnimatorKey: _frontPageLeftSlidingAnimatorKey,
                rightAnimatorKey: _frontPageRightSlidingAnimatorKey,
              );
            },
          ),


          backBuilder: (_) => ValueListenableBuilder(
            valueListenable: dataStore.backTasksListenable(),
            builder: (_, Box<Task> box,__){
              return TasksGridPage(
                key: ValueKey(2),
                tasks: box.values.toList(),
                onFlip: (){
                  _pageFlipKey.currentState?.flip();
                },
                leftAnimatorKey: _backPageLeftSlidingAnimatorKey,
                rightAnimatorKey: _backPageRightSlidingAnimatorKey,
              );
            },
          ),
        );
      },
    );
  }
}
