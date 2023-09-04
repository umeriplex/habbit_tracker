import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

class HiveStoreData{
  static const String tasksBoxName = 'tasks';
  Future<void> init()async{
    await Hive.initFlutter();
    // Register the adapter for the Task class
    Hive.registerAdapter<Task>(TaskAdapter());
    // Open the boxes
    await Hive.openBox<Task>(tasksBoxName);
  }

  Future<void> createDemoTask({required List<Task> tasks})async{
    final box = Hive.box<Task>(tasksBoxName);
    if(box.isEmpty){
      await box.addAll(tasks);
    }else{
      print('Demo has ${box.length} tasks already exist');
    }
  }


  ValueListenable<Box<Task>> tasksListenable(){
    final box = Hive.box<Task>(tasksBoxName);
    return box.listenable();
  }
}

final dataStoreProvider = Provider<HiveStoreData>((ref) {
  return HiveStoreData();
});