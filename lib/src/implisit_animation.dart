import 'package:flutter/material.dart';

class ImplisitAnimation extends StatefulWidget {
  const ImplisitAnimation(
      {super.key, required this.color, required this.colorName});

  final Color color;
  final String colorName;

  @override
  State<ImplisitAnimation> createState() => _ImplisitAnimationState();
}

class _ImplisitAnimationState extends State<ImplisitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Color color;
  late String colorName;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    color = widget.color;
    colorName = widget.colorName;
  }

  @override
  void didUpdateWidget(covariant ImplisitAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color ||
        widget.colorName != oldWidget.colorName) {
      performAnimation();
    }
  }

  void performAnimation() {
    final startColor = color;
    final startColorName = colorName;
    final Animation<double> curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    final tween = Tween<double>(begin: 0, end: 1).animate(curve);

    // for deleting letter
    final oneLeterDeleteTime = 500 / startColorName.length;

    // for adding letter
    final oneLeterAddingTime = 500 / widget.colorName.length;

    tween.addListener(() {
      setState(() {
        color = Color.lerp(startColor, widget.color, tween.value)!;

        if (tween.value < 0.5) {
          final deletedLetterPrMs = (tween.value * 1000) / oneLeterDeleteTime;
          colorName = startColorName.substring(
              0, startColorName.length - deletedLetterPrMs.toInt() - 1);
        } else {
          final addedLetterPrMs =
              ((tween.value - 0.5) * 1000) / oneLeterAddingTime;
          colorName = widget.colorName.substring(
              0, addedLetterPrMs.toInt().clamp(0, widget.colorName.length));
        }
      });
    });

    controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 200,
      width: 200,
      alignment: Alignment.center,
      child: Text(colorName),
    );
  }
}
