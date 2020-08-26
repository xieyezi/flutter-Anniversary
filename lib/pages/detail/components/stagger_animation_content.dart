// ignore: must_be_immutable
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  final Widget animationYear;
  final Widget animationDay;
  Animation<double> height;
  Animation<double> top;

  StaggerAnimation({Key key, this.controller, this.animationYear, this.animationDay}) : super(key: key) {
    top = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.3, //间隔，
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    final double senceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -top.value,
            child: Container(
              width: senceWidth * 0.5,
              child: animationYear,
            ),
          ),
          Positioned(
            top: -top.value + 100,
            child: Container(
              width: senceWidth * 0.5,
              child: animationDay,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
