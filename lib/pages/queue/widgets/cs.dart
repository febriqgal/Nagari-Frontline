import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nagarifrontline/providers/branch/branch.dart';

import '../../../shared/widgets/show_dialog_app.dart';

class CsView extends HookConsumerWidget {
  const CsView(
    this.csCurrentQueueNumber, {
    super.key,
    required this.audioCache,
    required this.flutterTts,
  });

  final String csCurrentQueueNumber;
  final AudioPlayer audioCache;
  final FlutterTts flutterTts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> extra =
        GoRouterState.of(context).extra as Map<String, dynamic>;
    final csIsButtonEnabled = useState(true);
    final csQueueNumberStateLocal = useState(0);
    final csPosisi = useState(1);

    void csAddPosisi() {
      if (csPosisi.value < 9) csPosisi.value++;
    }

    void csMinPosisi() {
      if (csPosisi.value > 1) csPosisi.value--;
    }

    Future<void> playAudioAndSpeak(String number) async {
      await audioCache.play(AssetSource("sounds/tingtung.wav"));
      await audioCache.onPlayerComplete.first;
      await flutterTts.setSpeechRate(0.3);
      await flutterTts.speak(
          "Nomor Antrian, B, ${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Castemer Servis ${csPosisi.value}");
      await flutterTts.awaitSpeakCompletion(true);
    }

    Widget buildcsControls() {
      return Column(
        spacing: 16,
        children: [
          const Text(
            'cs',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: csMinPosisi,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedRemoveCircle,
                  color: Colors.blue,
                  size: 24.0,
                ),
              ),
              Text(
                "${csPosisi.value}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: csAddPosisi,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedAddCircle,
                  color: Colors.blue,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget buildQueueNumberDisplay() {
      return Column(
        spacing: 0,
        children: [
          const Text(
            'Customer Service',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Nomor Antrian Saat Ini :',
            style: TextStyle(fontSize: 20),
          ),
        ],
      );
    }

    return Column(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        extra["role"] != "display"
            ? buildcsControls()
            : buildQueueNumberDisplay(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            'B${csCurrentQueueNumber.padLeft(3, '0')}',
            style: const TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        if (extra["role"] != "display")
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: csIsButtonEnabled.value
                    ? () async {
                        csQueueNumberStateLocal.value =
                            int.parse(csCurrentQueueNumber) - 1;
                        ref.read(branchProvider.notifier).updateCS(
                              csCurrentQueueNumber:
                                  csQueueNumberStateLocal.value,
                              csNumber: csPosisi.value,
                              csSoundActive: true,
                            );
                        final number = csQueueNumberStateLocal.value.toString();
                        if (context.mounted) {
                          showDialogApp(
                            context: context,
                            title: "B${number.padLeft(3, '0')}",
                            subtitle: "CS ${csPosisi.value}",
                          );
                        }
                        await playAudioAndSpeak(number);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    : null,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowLeft04,
                  color: Colors.blue,
                  size: 24.0,
                ),
              ),
              ElevatedButton(
                onPressed: csIsButtonEnabled.value
                    ? () async {
                        final number = csCurrentQueueNumber;
                        showDialogApp(
                          context: context,
                          title: "B${csCurrentQueueNumber.padLeft(3, '0')}",
                          subtitle: "CS ${csPosisi.value}",
                        );
                        await flutterTts.setSpeechRate(0.3);
                        await flutterTts.speak(
                            "Di ulangi, Nomor Antrian, B, ${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Castomer Servis ${csPosisi.value}");
                        await flutterTts.awaitSpeakCompletion(true);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    : null,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCircleArrowReload01,
                  color: Colors.blue,
                  size: 24.0,
                ),
              ),
              ElevatedButton(
                onPressed: csIsButtonEnabled.value
                    ? () async {
                        csQueueNumberStateLocal.value =
                            int.parse(csCurrentQueueNumber) + 1;
                        ref.read(branchProvider.notifier).updateCS(
                              csCurrentQueueNumber:
                                  csQueueNumberStateLocal.value,
                              csNumber: csPosisi.value,
                              csSoundActive: true,
                            );
                      }
                    : null,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight04,
                  color: Colors.blue,
                  size: 24.0,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
