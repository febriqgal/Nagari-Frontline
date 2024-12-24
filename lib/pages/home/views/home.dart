import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nagarifrontline/pages/login/views/login.dart';
import 'package:nagarifrontline/pages/print/views/print.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../widgets/button_with_background_image.dart';
import '../../queue/views/queue.dart';

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
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                ? MediaQuery.of(context).size.width * 0.25
                : 16,
          ),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonWithBackgroundImageApp(
                label: Text(
                  "Teller",
                  style: TextStyle(color: Colors.white),
                ),
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
                label: Text(
                  "Customer Service",
                  style: TextStyle(color: Colors.white),
                ),
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
                label: Text(
                  "Display",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  context.pushNamed(
                    QueuePage.name,
                    extra: {
                      "role": "display",
                    },
                  );
                },
              ),
              ButtonWithBackgroundImageApp(
                label: Text(
                  "Cetak Antrian",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  context.pushNamed(PrintPage.name);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => context.goNamed(LoginPage.name),
        child: Container(
          height: 56,
          width: 56,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/bg.jpg',
                cacheHeight: 1080,
                cacheWidth: 1920,
                fit: BoxFit.cover,
              ).image,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedLogout01,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
