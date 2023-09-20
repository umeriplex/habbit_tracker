import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/models/front_or_back_side.dart';
import 'package:habit_tracker_flutter/presistance/hive_data_store.dart';

class AppThemeManager extends StateNotifier<AppThemeSettings>{
  AppThemeManager({
    required this.hiveStoreData,
    required this.side,
    required AppThemeSettings appThemeSettings
  }) : super(appThemeSettings);
  final HiveStoreData hiveStoreData;
  final FrontOrBackSide side;

  void updateColorIndex(int colorIndex){
    state = state.copyWith(colorIndex: colorIndex);
    hiveStoreData.setAppThemeSettings(settings: state, side: side);
  }

  void updateVariantIndex(int variantIndex){
    state = state.copyWith(variantIndex: variantIndex);
    hiveStoreData.setAppThemeSettings(settings: state, side: side);
  }

}