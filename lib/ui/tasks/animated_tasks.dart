import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/tasks/tasks_compl_ring.dart';
import '../theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  final String iconName;
  final bool isCompleted;
  final ValueChanged<bool>? onComplete;
  const AnimatedTask({Key? key, required this.iconName, required this.isCompleted, this.onComplete}) : super(key: key);

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curveAnimation;
  var _isCheckCompleted = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeInOut));
    _controller.addStatusListener(_updateAnimationStatus);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeStatusListener(_updateAnimationStatus);
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if(!widget.isCompleted && _controller.status != AnimationStatus.completed){
      _controller.forward();
    }else if (!_isCheckCompleted){
      widget.onComplete?.call(false);
      _controller.value = 0.0;
    }
  }

  void _handleTapUp() {
    if(_controller.status != AnimationStatus.completed){
      _controller.reverse();
    }
  }

  void _updateAnimationStatus(AnimationStatus status){
    if(status == AnimationStatus.completed){
      widget.onComplete?.call(true);
      if(mounted){
        setState(() =>_isCheckCompleted = true);
      }
      Future.delayed(const Duration(milliseconds: 800), () {
        if(mounted){
          setState(() => _isCheckCompleted = false);
        }
      });
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
          final themeData = AppTheme.of(context);
          final progress = widget.isCompleted ? 1.0 : _curveAnimation.value;
          final hasCompleted = progress == 1.0;
          final iconColor = hasCompleted ? themeData.accentNegative : themeData.taskIcon;
          return Stack(
            children: [
              TasksCompRing(
                progress: progress,
              ),
              Positioned.fill(
                child: CenteredSvgIcon(
                  iconName: _isCheckCompleted && hasCompleted ? AppAssets.check : widget.iconName,
                  color: iconColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
