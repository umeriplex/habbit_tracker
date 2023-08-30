import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';

import 'animated_button.dart';

class ButtonsView extends StatelessWidget {
  const ButtonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          AnimatedButton(
            text: 'PUSH ME BRO!',
            buttonColor: AppColors.magenta[0],
            shadowColor: AppColors.magenta[2],
          ),
          SizedBox(height: 20),
          AnimatedButton(
            text: 'PRESS ME',
            buttonColor: AppColors.yellow[0],
            shadowColor: AppColors.yellow[2],
          ),
          SizedBox(height: 20),
          AnimatedButton(
            text: 'PRESS ME 😎',
            buttonColor: AppColors.purple[0],
            shadowColor: AppColors.purple[2],
          ),
        ],
      )
    );
  }
}
