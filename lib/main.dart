import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/presistance/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final dataStore = HiveStoreData();
  await dataStore.init();
  await dataStore.createDemoTask(tasks: [
    Task.create(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
    Task.create(name: 'Walk the Dog', iconName: AppAssets.dog),
    Task.create(name: 'Do Some Coding', iconName: AppAssets.html),
    Task.create(name: 'Meditate', iconName: AppAssets.meditation),
    Task.create(name: 'Do 10 Push-ups', iconName: AppAssets.pushups),
  ]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}
