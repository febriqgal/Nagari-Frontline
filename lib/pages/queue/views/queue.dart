import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../widgets/button_back.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../widgets/cs.dart';
import '../widgets/teller.dart';

class QueuePage extends HookConsumerWidget {
  static const bool isRoot = true;
  static const String name = "queue";
  static String get path => isRoot ? '/$name' : name;
  const QueuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioCache = AudioPlayer();
    final Map<String, dynamic> extra =
        GoRouterState.of(context).extra as Map<String, dynamic>;

    if (extra["role"] == "teller") {
      return Scaffold(
        appBar: AppBar(
          leading: Container(
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: ButtonBackApp(color: Colors.white, size: 24)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TellerView(audioCache: audioCache),
              ],
            ),
          ),
        ),
      );
    }
    if (extra["role"] == "cs") {
      return Scaffold(
        appBar: AppBar(
          leading: Container(
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: ButtonBackApp(color: Colors.white, size: 24)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CsView(audioCache: audioCache),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: ButtonBackApp(color: Colors.white, size: 24)),
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          crossAxisCount:
              ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 2 : 1,
        ),
        children: [
          TellerView(audioCache: audioCache),
          CsView(audioCache: audioCache),
        ],
      ),
    );
  }
}
