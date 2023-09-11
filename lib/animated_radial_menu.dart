// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class RadialMenu extends StatefulWidget {
  // will take in list of buttons
  final List<RadialButton> children;

  // used for positioning the widget
  final AlignmentGeometry centerButtonAlignment;

  // set main button size
  final double centerButtonSize;

  // set animation duration
  final Duration? duration;
  // constructor for main button
  const RadialMenu({
    super.key,
    required this.children,
    this.centerButtonSize = 0.5,
    this.centerButtonAlignment = Alignment.center,
    this.duration,
  });

  @override
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  // used to control animations
  AnimationController? controller;

  // controller gets initialized here
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: widget.duration ?? const Duration(milliseconds: 900),
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.centerButtonAlignment,
      child: SizedBox(
        width: 250,
        height: 250,
        child: RadialAnimation(
          controller: controller!,
          radialButtons: widget.children,
          centerSizeOfButton: widget.centerButtonSize,
        ),
      ),
    );
  }

  // controller gets disposed here
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

// Here all the animation will take place
class RadialAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;
  final List<RadialButton> radialButtons;
  final double centerSizeOfButton;

  RadialAnimation(
      {super.key,
      required this.controller,
      required this.radialButtons,
      this.centerSizeOfButton = 0.5})
      :
        // translation animation
        translation = Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),

        // scaling animation
        scale = Tween<double>(begin: centerSizeOfButton * 2, end: 0).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),

        // rotation animation
        rotation = Tween<double>(begin: 0, end: 360).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.7, curve: Curves.decelerate),
          ),
        );

  @override
  Widget build(BuildContext context) {
    // will provide angle for further calculation
    double generatedAngle = 360 / (radialButtons.length);
    double iconAngle;

    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: Stack(alignment: Alignment.center, children: [
                // generates list of buttons
                ...radialButtons.map((index) {
                  iconAngle = radialButtons.indexOf(index) * generatedAngle;
                  return _buildBtn(iconAngle,
                      color: index.backgroundColor,
                      icon: index.icon,
                      onPress: index.onPressed);
                }),
                // secondary button animation
                Transform.scale(
                  scale: scale.value - (centerSizeOfButton * 2 - 0.25),
                  child: FloatingActionButton(
                    onPressed: close,
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.close),
                  ),
                ),
                // primary button animation
                Transform.scale(
                  scale: scale.value,
                  child: FloatingActionButton(
                    onPressed: open,
                    backgroundColor: Colors.indigo,
                    child: const Icon(Icons.add),
                  ),
                )
              ]));
        });
  }

  // will show child buttons
  void open() => controller.forward();

  // will hide child buttons
  void close() => controller.reverse();

  // build custom child buttons
  Widget _buildBtn(double angle,
      {Function? onPress, Color? color, Icon? icon}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
            (translation.value) * cos(rad), (translation.value) * sin(rad)),
      child: FloatingActionButton(
        backgroundColor: color,
        onPressed: () {
          onPress!();
          close();
        },
        elevation: 0,
        child: icon,
      ),
    );
  }
}

class RadialButton {
  // background colour of the button surrounding the icon
  final Color backgroundColor;

  // sets icon of the child buttons
  final Icon icon;

  // onPress function of the child buttons
  final Function onPressed;

  // constructor for child buttons
  RadialButton({
    this.backgroundColor = Colors.orange,
    required this.icon,
    required this.onPressed,
  });
}
