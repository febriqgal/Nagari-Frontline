import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../queue/views/queue.dart';
import '../../../widgets/button_with_background_image.dart';

class HomePage extends HookConsumerWidget {
  static const bool isRoot = true;
  static const String name = "home";
  static String get path => isRoot ? '/$name' : name;

  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_nagari.png',
              height: 30,
              cacheHeight: 400,
            ),
            const Text(
              'Nagari Frontline',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonWithBackgroundImageApp(
                label: "Teller",
                onPressed: () {
                  context.pushNamed(
                    QueuePage.name,
                    extra: {
                      "role": "teller",
                    },
                  );
                },
              ),
              ButtonWithBackgroundImageApp(
                label: "Customer Service",
                onPressed: () {
                  context.pushNamed(
                    QueuePage.name,
                    extra: {
                      "role": "cs",
                    },
                  );
                },
              ),
              ButtonWithBackgroundImageApp(
                label: "Display",
                onPressed: () {
                  context.pushNamed(
                    QueuePage.name,
                    extra: {
                      "role": "display",
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
