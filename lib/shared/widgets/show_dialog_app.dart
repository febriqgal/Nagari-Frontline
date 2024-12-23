import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<dynamic> showDialogApp({
  required BuildContext context,
  required String title,
  required String subtitle,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(
          ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 100 : 16,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              style: TextStyle(
                  fontSize: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                      ? 40
                      : 20),
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Nomor Antrian ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/belll.png',
              height: 200,
            ),
            Text.rich(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                      ? 40
                      : 20),
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Silahkan menuju ke\n',
                  ),
                  TextSpan(
                    text: subtitle,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
