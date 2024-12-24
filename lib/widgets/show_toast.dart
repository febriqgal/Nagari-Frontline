import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:toastification/toastification.dart';

ToastificationItem showToastSuccessApp({
  required BuildContext context,
  required String title,
  description,
  backgroundColor = Colors.white,
}) {
  return toastification.show(
    type: ToastificationType.success,
    context: context, // optional if you use ToastificationWrapper
    title: Text(title),
    description: description != null ? Text(description) : null,
    showProgressBar: false,
    alignment: Alignment.topCenter,
    icon: HugeIcon(
      icon: HugeIcons.strokeRoundedCheckmarkCircle02,
      color: Colors.blue,
      size: 24.0,
    ),
    autoCloseDuration: const Duration(seconds: 3),
    applyBlurEffect: false,
    backgroundColor: backgroundColor,
    animationDuration: const Duration(milliseconds: 300),
  );
}

ToastificationItem showToastWarningApp({
  required BuildContext context,
  required String title,
  description,
  backgroundColor = Colors.white,
}) {
  return toastification.show(
    type: ToastificationType.warning,
    context: context, // optional if you use ToastificationWrapper
    title: Text(title),
    description: description != null ? Text(description) : null,
    showProgressBar: false,
    alignment: Alignment.topCenter,
    icon: HugeIcon(
      icon: HugeIcons.strokeRoundedAlert02,
      color: Colors.red,
      size: 24.0,
    ),
    autoCloseDuration: const Duration(seconds: 3),
    applyBlurEffect: false,
    backgroundColor: backgroundColor,
    animationDuration: const Duration(milliseconds: 300),
  );
}
