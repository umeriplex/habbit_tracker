import 'package:flutter/material.dart';
import 'button.dart';
class AnimatedButton extends StatefulWidget {
  const AnimatedButton({Key? key, required this.text, required this.buttonColor, required this.shadowColor}) : super(key: key);
  final String text;
  final Color buttonColor;
  final Color shadowColor;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curveAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.ease));
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if(_controller.value < 7.0){
      _controller.forward();
    }else{
      _controller.value = 0.0;
    }
  }

  void _handleTapUp() {
    if(_controller.value > 0.0){
      _controller.reverse();
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: (_) =>_handleTapUp(),
      onTapCancel: _handleTapUp,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (context, child) {
          final progress = _curveAnimation.value * 10;
          final hasCompleted = progress > 7.0;
          return ThreeDButton(
            value: hasCompleted ? 7.0 : progress,
            text: widget.text,
            buttonColor: widget.buttonColor,
            buttonShadowColor: widget.shadowColor,

          );
        },
      ),
    );
  }
}
