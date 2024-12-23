import 'package:flutter/material.dart';

class ButtonWithBackgroundImageApp extends StatelessWidget {
  final void Function() onPressed;
  final Widget label;
  const ButtonWithBackgroundImageApp({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/bg.jpg',
                cacheHeight: 1080,
                cacheWidth: 1920,
                fit: BoxFit.cover,
              ).image,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(99),
            onTap: onPressed,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: label,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
