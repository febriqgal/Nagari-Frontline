import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
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
    final csIsButtonEnabled = useState(true);
    final csQueueNumber = useState(9);
    final csPosisi = useState(1);
    final Map<String, dynamic> extra =
        GoRouterState.of(context).extra as Map<String, dynamic>;

    void csAddPosisi() {
      if (csPosisi.value < 9) csPosisi.value++;
    }

    void csMinPosisi() {
      if (csPosisi.value > 1) csPosisi.value--;
    }

    Future<void> playAudioAndSpeak(String number, int posisi) async {
      await audioCache.play(AssetSource("sounds/tingtung.wav"));
      await audioCache.onPlayerComplete.first;
      await flutterTts.setSpeechRate(0.3);
      await flutterTts.speak(
          "Nomor Antrian, Aa${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Customer Service $posisi");
      await flutterTts.awaitSpeakCompletion(true);
    }

    return Column(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          spacing: 16,
          children: [
            const Text(
              'Customer Service',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (extra["role"] != "display")
              Column(
                spacing: 16,
                children: [
                  Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: csMinPosisi,
                        child: HugeIcon(
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
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedAddCircle,
                          color: Colors.blue,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              const Text(
                'Nomor Antrian Saat Ini :',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
        GestureDetector(
          onLongPress: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: const Center(child: Text('Konfirmasi')),
                content: const Text(
                    'Apakah Anda Mereset Nomor Antrian Customer Service?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tidak'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      csQueueNumber.value = 1;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ya'),
                  ),
                ],
              ),
            );
          },
          child: Container(
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
        ),
        if (extra["role"] != "display")
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: csIsButtonEnabled.value
                    ? () async {
                        if (csQueueNumber.value > 1) {
                          csQueueNumber.value--;
                        }
                        final number = csCurrentQueueNumber;
                        if (context.mounted) {
                          showDialogApp(
                            context: context,
                            title: "A${csCurrentQueueNumber.padLeft(3, '0')}",
                            subtitle: "CS ${csPosisi.value}",
                          );
                        }
                        await playAudioAndSpeak(number, csPosisi.value);
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
                          title: "A${csCurrentQueueNumber.padLeft(3, '0')}",
                          subtitle: "CS ${csPosisi.value}",
                        );
                        await flutterTts.setSpeechRate(0.3);
                        await flutterTts.speak(
                            "Di ulangi, Nomor Antrian, Aa${number.length == 1 ? " nol nol $number" : number.length == 2 ? " nol $number" : " $number"} , Silahkan menuju ke Customer Service ${csPosisi.value}");
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
                        csQueueNumber.value++;
                        final number = csCurrentQueueNumber;
                        if (context.mounted) {
                          showDialogApp(
                            context: context,
                            title: "A${csCurrentQueueNumber.padLeft(3, '0')}",
                            subtitle: "CS ${csPosisi.value}",
                          );
                        }
                        await playAudioAndSpeak(number, csPosisi.value);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
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
