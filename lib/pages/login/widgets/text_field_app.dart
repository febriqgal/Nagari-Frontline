import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class TextFieldApp extends HookConsumerWidget {
  const TextFieldApp({
    super.key,
    required this.controller,
    this.maxLength,
    required this.title,
    this.keyboardType,
    this.textInputAction,
    required this.icon,
    this.inputFormatters,
    this.onChanged,
  });

  final TextEditingController controller;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String title;
  final void Function(String)? onChanged;
  final HugeIcon icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateCount = useState<int>(0);
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
      decoration: inputDecorationApp(stateCount: stateCount),
    );
  }

  InputDecoration inputDecorationApp({required ValueNotifier<int> stateCount}) {
    return InputDecoration(
      hintStyle: const TextStyle(color: Colors.black26),
      counterText: "",
      suffixIcon: GestureDetector(
          onTap: () {
            controller.clear();
            stateCount.value = 0;
          },
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedCancelSquare,
            color: Colors.blue,
            size: 20.0,
          )),
      prefixIcon: icon,
      hintText: title,
    );
  }
}
