import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class ButtonBackApp extends StatelessWidget {
  final Color color;
  final double size;
  const ButtonBackApp({
    super.key,
    required this.color,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedArrowLeft04,
        color: color,
        size: size,
      ),
      onPressed: () {
        context.pop();
      },
    );
  }
}
