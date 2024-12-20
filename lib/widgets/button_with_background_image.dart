import 'package:flutter/material.dart';

class ButtonWithBackgroundImageApp extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  const ButtonWithBackgroundImageApp({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
