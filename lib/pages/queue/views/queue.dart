import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nagarifrontline/providers/branch/branch.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../widgets/button_back.dart';
import '../widgets/cs.dart';
import '../widgets/teller.dart';

class QueuePage extends HookConsumerWidget {
  static const bool isRoot = true;
  static const String name = "queue";
  static String get path => isRoot ? '/$name' : name;
  const QueuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brance = ref.watch(branchProvider);
    final AudioPlayer audioCache = AudioPlayer();
    final FlutterTts flutterTts = FlutterTts();
    final Map<String, dynamic> extra =
        GoRouterState.of(context).extra as Map<String, dynamic>;
    return switch (brance) {
      AsyncData(:final value) => extra["role"] == "teller"
          ? Scaffold(
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
                      TellerView(
                        value["tellerCurrentQueueNumber"].toString(),
                        audioCache: audioCache,
                        flutterTts: flutterTts,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : extra["role"] == "cs"
              ? Scaffold(
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
                          CsView(
                            value["csCurrentQueueNumber"].toString(),
                            audioCache: audioCache,
                            flutterTts: flutterTts,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Scaffold(
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
                          ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                              ? 2
                              : 1,
                    ),
                    children: [
                      TellerView(
                        value["tellerCurrentQueueNumber"].toString(),
                        audioCache: audioCache,
                        flutterTts: flutterTts,
                      ),
                      CsView(
                        value["csCurrentQueueNumber"].toString(),
                        audioCache: audioCache,
                        flutterTts: flutterTts,
                      ),
                    ],
                  ),
                ),
      AsyncError(:final error) => Scaffold(
          body: Center(
            child: Text("Error: $error"),
          ),
        ),
      _ => Scaffold(
          body: Center(
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
    };
  }
}
