import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';

class ThreeDButton extends StatelessWidget {
  final double value;
  final Color buttonColor;
  final Color buttonShadowColor;
  final String text;
  const ThreeDButton({Key? key, required this.value, required this.buttonColor, required this.buttonShadowColor, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.maxFinite,
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: 60,
              margin: const EdgeInsets.only(top: 7),
              decoration: BoxDecoration(
                color: buttonShadowColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'PUSH ME',
                  textAlign: TextAlign.center,
                  style: TextStyles.taskName.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 60,
              margin: EdgeInsets.only(top: value),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyles.taskName.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
