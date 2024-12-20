import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'router.dart';
import 'shared/widgets/theme_data_app.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return ResponsiveBreakpoints.builder(
          child: MediaQuery(
            data: data.copyWith(
              textScaler: TextScaler.linear(1),
              // textScaleFactor:
              //     data.textScaleFactor > 1.0 ? 1.0 : data.textScaleFactor,
            ),
            child: child!,
          ),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Nagari Frontline',
      theme: themeDataApp(),
      routerConfig: routerApp(),
    );
  }
}
