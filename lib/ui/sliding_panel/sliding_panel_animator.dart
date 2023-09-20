import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/animation/animation_controller_state.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';

class SlidingPanelAnimator extends StatefulWidget {
  const SlidingPanelAnimator({Key? key, required this.direction, required this.child}) : super(key: key);
  final SlideDirection direction;
  final Widget child;

  @override
  State<SlidingPanelAnimator> createState() => SlidingPanelAnimatorState(Duration(milliseconds: 200));
}

class SlidingPanelAnimatorState extends AnimationControllerState<SlidingPanelAnimator> {
  SlidingPanelAnimatorState(Duration duration) : super(duration);

  void slideIn(){
    animationController.forward();
  }

  void slideOut(){
    debugPrint('SlidingPanelAnimatorState.slideOut');
    animationController.reverse();
  }

  late final _curveValue = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOut,
  )
  );
  double _getOffsetX(double animationValue, double screenWidth){
    final offset = widget.direction == SlideDirection.rightToLeft
        ?
    screenWidth - SlidingPanel.leftPanelFixedWidth
        :
    -SlidingPanel.leftPanelFixedWidth;
    return offset * (1.0 - animationValue);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curveValue,
      child: SlidingPanel(
        direction: widget.direction,
        child: widget.child,
      ),
      builder: (context,child){
        final animationValue = animationController.value;
        if(animationValue == 0.0){
          return Container();
        }
        final screenWidth = MediaQuery.of(context).size.width;
        final offsetX = _getOffsetX(animationValue, screenWidth);
        return Transform.translate(offset: Offset(offsetX,0),child: child,);
      },
    );
  }
}
