import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';

class TextFieldApp extends StatelessWidget {
  const TextFieldApp({
    super.key,
    required this.controller,
    this.maxLength,
    required this.stateCount,
    required this.title,
    this.keyboardType,
    this.textInputAction,
    required this.icon,
    this.inputFormatters,
    this.onChanged,
  });

  final TextEditingController controller;
  final int? maxLength;
  final ValueNotifier<int> stateCount;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String title;
  final void Function(String)? onChanged;
  final HugeIcon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      maxLength: maxLength,
      onChanged: onChanged != null
          ? (value) {
              onChanged!(value);
              stateCount.value = value.length;
            }
          : (value) {
              stateCount.value = value.length;
            },
      decoration: inputDecorationApp(),
    );
  }

  InputDecoration inputDecorationApp() {
    return InputDecoration(
      hintStyle: const TextStyle(color: Colors.black26),
      counterText: "",
      suffixIcon: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${stateCount.value}/$maxLength",
            style: TextStyle(
              fontSize: 8,
              color: Colors.blue.withValues(
                alpha: 0.5,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                controller.clear();
                stateCount.value = 0;
              },
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedCancelSquare,
                color: Colors.blue,
                size: 20.0,
              )),
          SizedBox(width: 8),
        ],
      ),
      prefixIcon: icon,
      hintText: title,
    );
  }
}
