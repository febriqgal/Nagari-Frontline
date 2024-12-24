import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marqueer/marqueer.dart';
import 'package:nagarifrontline/providers/branch/branch.dart';
import 'package:nagarifrontline/shared/widgets/show_dialog_app.dart';

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
    final branch = ref.watch(branchProvider);
    final audioCache = AudioPlayer();
    final flutterTts = FlutterTts();
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;

    if (extra["role"] == "display") {
      ref.listen<AsyncValue>(branchProvider, (previous, next) async {
        log("previous: $previous, next: $next");
        if (previous != next) {
          String keyApp = '';
          if (previous is AsyncData && next is AsyncData) {
            final prevData = previous.value as Map<String, dynamic>;
            final nextData = next.value as Map<String, dynamic>;
            prevData.forEach((key, value) {
              if (nextData[key] != value) {
                log("keyyyy $key");
                keyApp = key;
              }
            });
          }

          if (keyApp == "tellerCurrentQueueNumber" ||
              keyApp == "tellerNumber") {
            showDialogApp(
              context: context,
              title:
                  "A${next.value["tellerCurrentQueueNumber"].toString().padLeft(3, '0')}",
              subtitle: "Teller ${next.value["tellerNumber"]}",
            );
            final number = next.value["tellerCurrentQueueNumber"].toString();
            final posisi = next.value["tellerNumber"].toString();
            await audioCache.play(AssetSource("sounds/tingtung.wav"));
            await audioCache.onPlayerComplete.first;
            await flutterTts.setSpeechRate(0.3);
            await flutterTts.speak(
                "Nomor Antrian, Aa, ${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Teller $posisi");
            await flutterTts.awaitSpeakCompletion(true);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          } else if (keyApp == "csCurrentQueueNumber" || keyApp == "csNumber") {
            showDialogApp(
              context: context,
              title:
                  "B${next.value["csCurrentQueueNumber"].toString().padLeft(3, '0')}",
              subtitle: "CS ${next.value["csNumber"]}",
            );
            final number = next.value["csCurrentQueueNumber"].toString();
            final posisi = next.value["csNumber"].toString();
            await audioCache.play(AssetSource("sounds/tingtung.wav"));
            await audioCache.onPlayerComplete.first;
            await flutterTts.setSpeechRate(0.3);
            await flutterTts.speak(
                "Nomor Antrian, B, ${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Castemer Servis $posisi");
            await flutterTts.awaitSpeakCompletion(true);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        }
      });
    }

    return branch.when(
      data: (value) {
        final role = extra["role"];
        final appBar = AppBar(
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
            child: ButtonBackApp(color: Colors.white, size: 24),
          ),
        );

        if (role == "teller") {
          return Scaffold(
            appBar: appBar,
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
          );
        } else if (role == "cs") {
          return Scaffold(
            appBar: appBar,
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
          );
        } else {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TellerView(
                        value["tellerCurrentQueueNumber"].toString(),
                        audioCache: audioCache,
                        flutterTts: flutterTts,
                      ),
                    ),
                    Gap(16),
                    Expanded(
                      child: CsView(
                        value["csCurrentQueueNumber"].toString(),
                        audioCache: audioCache,
                        flutterTts: flutterTts,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 50,
              child: Marqueer(
                // pps: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_print.png',
                      height: 20,
                      cacheHeight: 400,
                      color: Colors.white,
                    ),
                    Gap(32),
                    Text(
                      "Bersama Membina Citra Membangun Negeri",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Gap(32),
                  ],
                ),
              ),
            ),
          );
        }
      },
      error: (error, _) => Scaffold(
        body: Center(
          child: Text("Error: $error"),
        ),
      ),
      loading: () => Scaffold(
        body: Center(
          child: const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
