import 'dart:math';

import 'package:flutter/material.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({Key? key, required this.frontBuilder, required this.backBuilder}) : super(key: key);
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;

  @override
  State<PageFlipBuilder> createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder> with SingleTickerProviderStateMixin {

  late final _controller = AnimationController(
    lowerBound: -1.0,
    upperBound: 1.0,
    duration: Duration(milliseconds: 500),
    vsync: this,
  );
  bool _showFrontSide = true;

  void flip (){
    if(_showFrontSide){
      _controller.forward();
    }else{
      _controller.reverse();
    }
  }

  void _updateStatus(AnimationStatus status) {
    if(status == AnimationStatus.completed || status == AnimationStatus.dismissed){
      setState(() {
        _controller.value = 0.0;
        _showFrontSide = !_showFrontSide;
      });
    }
  }
  @override
  void initState() {
    _controller.addStatusListener(_updateStatus);
    _controller.value = 0.0;
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    _controller.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _handleDragUpdates(DragUpdateDetails details){
    // final delta = details.primaryDelta!;
    // final fractionDragged = delta / context.size!.width;
    // _controller.value -= 5 * fractionDragged;
    final screenWith = MediaQuery.of(context).size.width;
    _controller.value += details.primaryDelta! / screenWith;
  }

  void _handleDragEnds (DragEndDetails details){
    if(
    _controller.isAnimating ||
    _controller.status == AnimationStatus.completed ||
    _controller.status == AnimationStatus.dismissed
    ){return;}

    final screenWidth = MediaQuery.of(context).size.width;
    final currentVelocity = details.velocity.pixelsPerSecond.dx / screenWidth;
    if(_controller.value == 0.0 && currentVelocity == 0.0){return;}

    const flingVelocity = 2.0;
    if(_controller.value > 0.5 || _controller.value > 0.0 && currentVelocity > flingVelocity){
      _controller.fling(velocity: flingVelocity);
    }else if (_controller.value < -0.5 || _controller.value < 0.0 && currentVelocity < -flingVelocity){
      _controller.fling(velocity: -flingVelocity);
    }else if (_controller.value > 0.0 || _controller.value > 0.5 && currentVelocity < -flingVelocity){
      _controller.value -= 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: -flingVelocity);
    }else if (_controller.value > -0.5 || _controller.value < -0.5 && currentVelocity > flingVelocity){
      _controller.value += 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: flingVelocity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdates,
      onHorizontalDragEnd: _handleDragEnds,
      child: AnimatedFlipPageBuilder(
        animation: _controller,
        frontBuilder: widget.frontBuilder,
        backBuilder: widget.backBuilder,
        showFrontSide: _showFrontSide,
      ),
    );
  }
}

class AnimatedFlipPageBuilder extends AnimatedWidget {
  const AnimatedFlipPageBuilder({Key? key, required Animation<double> animation , required this.frontBuilder, required this.backBuilder, required this.showFrontSide}) : super(key: key,listenable: animation);
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  final bool showFrontSide;

  Animation<double> get animation => listenable as Animation<double>;
  bool get _isAnimationFirstHalf => animation.value.abs() < 0.5;

  double _getTilt () {
    var tilt = (animation.value - 0.5).abs() - 0.5;
    if(animation.value < -0.5){
      tilt = 1.0 + animation.value;
    }
    return tilt * (_isAnimationFirstHalf ? -0.003 : 0.003);
  }

  double _rotationAngle () {
    final rotationValue = animation.value * pi;
    if(animation.value > 0.5){
      return pi - rotationValue;
    }else if (animation.value > -0.5){
      return rotationValue;
    }else{
      return -pi - rotationValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isAnimationFirstHalf = animation.value < 0.5;
    // final child = isAnimationFirstHalf ? frontBuilder(context) : backBuilder(context);
    // final rotationValue = animation.value * pi;
    // final rotationAngle = animation.value > 0.5 ? pi - rotationValue : rotationValue;
    // var tilt = (animation.value - 0.5).abs() - 0.5;
    // tilt *= isAnimationFirstHalf ? -0.003 : 0.003;
    final child = _isAnimationFirstHalf ^ showFrontSide ? backBuilder(context) : frontBuilder(context);
    return Transform(
      transform: Matrix4.rotationY(_rotationAngle())..setEntry(3, 0, _getTilt()),
      alignment: Alignment.center,
      child: child,
    );
  }
}

