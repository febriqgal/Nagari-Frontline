import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nagarifrontline/providers/branch/branch.dart';

import '../../../shared/widgets/show_dialog_app.dart';

class TellerView extends HookConsumerWidget {
  const TellerView(
    this.tellerCurrentQueueNumber, {
    super.key,
    required this.audioCache,
    required this.flutterTts,
  });

  final String tellerCurrentQueueNumber;
  final AudioPlayer audioCache;
  final FlutterTts flutterTts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> extra =
        GoRouterState.of(context).extra as Map<String, dynamic>;
    final tellerIsButtonEnabled = useState(true);
    final tellerQueueNumberStateLocal = useState(0);
    final tellerPosisiStateLocal = useState(1);

    void tellerAddPosisi() {
      if (tellerPosisiStateLocal.value < 9) tellerPosisiStateLocal.value++;
    }

    void tellerMinPosisi() {
      if (tellerPosisiStateLocal.value > 1) tellerPosisiStateLocal.value--;
    }

    Future<void> playAudioAndSpeak(String number) async {
      await audioCache.play(AssetSource("sounds/tingtung.wav"));
      await audioCache.onPlayerComplete.first;
      await flutterTts.setSpeechRate(0.3);
      await flutterTts.speak(
          "Nomor Antrian, Aa, ${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Teller ${tellerPosisiStateLocal.value}");
      await flutterTts.awaitSpeakCompletion(true);
    }

    Widget buildTellerControls() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          const Text(
            'Teller',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: tellerMinPosisi,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedRemoveCircle,
                  color: Colors.blue,
                  size: 24.0,
                ),
              ),
              Text(
                "${tellerPosisiStateLocal.value}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: tellerAddPosisi,
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
            'Teller',
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        extra["role"] != "display"
            ? buildTellerControls()
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
            'A${tellerCurrentQueueNumber.padLeft(3, '0')}',
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
                onPressed: tellerIsButtonEnabled.value
                    ? () async {
                        tellerQueueNumberStateLocal.value =
                            int.parse(tellerCurrentQueueNumber) - 1;
                        ref.read(branchProvider.notifier).updateTeller(
                              tellerSoundActive: true,
                              tellerCurrentQueueNumber:
                                  tellerQueueNumberStateLocal.value,
                              tellerNumber: tellerPosisiStateLocal.value,
                            );
                        final number =
                            tellerQueueNumberStateLocal.value.toString();
                        if (context.mounted) {
                          showDialogApp(
                            context: context,
                            title: "A${number.padLeft(3, '0')}",
                            subtitle: "Teller ${tellerPosisiStateLocal.value}",
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
                onPressed: tellerIsButtonEnabled.value
                    ? () async {
                        final number = tellerCurrentQueueNumber;
                        showDialogApp(
                          context: context,
                          title: "A${tellerCurrentQueueNumber.padLeft(3, '0')}",
                          subtitle: "Teller ${tellerPosisiStateLocal.value}",
                        );
                        await flutterTts.setSpeechRate(0.3);
                        await flutterTts.speak(
                            "Di ulangi, Nomor Antrian, Aa, ${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Teller ${tellerPosisiStateLocal.value}");
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
                onPressed: tellerIsButtonEnabled.value
                    ? () async {
                        tellerQueueNumberStateLocal.value =
                            int.parse(tellerCurrentQueueNumber) + 1;
                        ref.read(branchProvider.notifier).updateTeller(
                              tellerSoundActive: true,
                              tellerCurrentQueueNumber:
                                  tellerQueueNumberStateLocal.value,
                              tellerNumber: tellerPosisiStateLocal.value,
                            );
                        // final number =
                        //     tellerQueueNumberStateLocal.value.toString();
                        // if (context.mounted) {
                        //   showDialogApp(
                        //     context: context,
                        //     title: "A${number.padLeft(3, '0')}",
                        //     subtitle: "Teller ${tellerPosisiStateLocal.value}",
                        //   );
                        // }
                        // await playAudioAndSpeak(number);
                        // if (context.mounted) {
                        //   Navigator.of(context).pop();
                        // }
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
