import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/tasks/tasks_compl_ring.dart';

import '../theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  final String iconName;
  const AnimatedTask({Key? key, required this.iconName}) : super(key: key);

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curveAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if(_controller.status != AnimationStatus.completed){
      _controller.forward();
    }else{
      _controller.value = 0.0;
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if(_controller.status != AnimationStatus.completed){
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (context, child) {
          final themeData = AppTheme.of(context);
          return Stack(
            children: [
              TasksCompRing(
                progress: _curveAnimation.value,
              ),
              Positioned.fill(
                child: CenteredSvgIcon(
                  iconName: widget.iconName,
                  color: themeData.taskIcon,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
