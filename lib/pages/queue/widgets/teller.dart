import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../shared/widgets/show_dialog_app.dart';

class TellerView extends HookConsumerWidget {
  TellerView({super.key, required audioCache});

  final audioCache = AudioPlayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> extra =
        GoRouterState.of(context).extra as Map<String, dynamic>;

    final tellerIsButtonEnabled = useState(true);
    final tellerQueueNumber = useState(8);
    final tellerPosisi = useState(1);

    Future<void> tellerPlaySoundSequence(List<String> soundFiles) async {
      for (var sound in soundFiles) {
        await audioCache.play(AssetSource(sound));
        await audioCache.onPlayerComplete.first;
      }
    }

    Future<List<String>> tellerGetNumberSounds(int number) async {
      List<String> sounds = [];
      log('getNumberSounds: $number');
      if (number < 10) {
        sounds.add('sounds/$number.wav');
      } else if (number == 10) {
        sounds.add('sounds/sepuluh.wav');
      } else if (number == 11) {
        sounds.add('sounds/sebelas.wav');
      } else if (number < 20) {
        sounds.add('sounds/${number % 10}.wav');
        sounds.add('sounds/belas.wav');
      } else {
        sounds.add('sounds/${number ~/ 10}.wav');
        sounds.add('sounds/puluh.wav');
        if (number % 10 > 0) sounds.add('sounds/${number % 10}.wav');
      }
      return sounds;
    }

    Future<void> playtellerQueueNumber(int number) async {
      List<String> sounds = ['sounds/a.wav'];
      log('playQueueNumber: $number');
      if (number <= 10) {
        sounds.add('sounds/$number.wav');
      } else if (number == 11) {
        sounds.add('sounds/sebelas.wav');
      } else if (number < 20) {
        sounds.add('sounds/${number % 10}.wav');
        sounds.add('sounds/belas.wav');
      } else if (number < 100) {
        sounds.add('sounds/${number ~/ 10}.wav');
        sounds.add('sounds/puluh.wav');
        if (number % 10 > 0) sounds.add('sounds/${number % 10}.wav');
      } else if (number < 200) {
        sounds.add('sounds/seratus.wav');
        if (number > 100) {
          sounds.addAll(await tellerGetNumberSounds(number - 100));
        }
      } else if (number < 300) {
        sounds.add('sounds/200.wav');
        if (number > 200) {
          sounds.addAll(await tellerGetNumberSounds(number - 200));
        }
      } else if (number < 400) {
        sounds.add('sounds/300.wav');
        if (number > 300) {
          sounds.addAll(await tellerGetNumberSounds(number - 300));
        }
      } else if (number < 500) {
        sounds.add('sounds/400.wav');
        if (number > 400) {
          sounds.addAll(await tellerGetNumberSounds(number - 400));
        }
      } else if (number < 600) {
        sounds.add('sounds/500.wav');
        if (number > 500) {
          sounds.addAll(await tellerGetNumberSounds(number - 500));
        }
      } else if (number < 700) {
        sounds.add('sounds/600.wav');
        if (number > 600) {
          sounds.addAll(await tellerGetNumberSounds(number - 600));
        }
      } else if (number < 800) {
        sounds.add('sounds/700.wav');
        if (number > 700) {
          sounds.addAll(await tellerGetNumberSounds(number - 700));
        }
      } else if (number < 900) {
        sounds.add('sounds/800.wav');
        if (number > 800) {
          sounds.addAll(await tellerGetNumberSounds(number - 800));
        }
      } else if (number < 1000) {
        sounds.add('sounds/900.wav');
        if (number > 900) {
          sounds.addAll(await tellerGetNumberSounds(number - 900));
        }
      }
      await tellerPlaySoundSequence(sounds);
    }

    void tellerDisableButton() => tellerIsButtonEnabled.value = false;
    void tellerEnableButton() {
      tellerIsButtonEnabled.value = true;
      Navigator.of(context).pop();
    }

    void tellerAddPosisi() {
      if (tellerPosisi.value < 9) tellerPosisi.value++;
    }

    void tellerMinPosisiAntri() {
      if (tellerQueueNumber.value > 1) tellerQueueNumber.value--;
    }

    void tellerMinPosisi() {
      if (tellerPosisi.value > 1) tellerPosisi.value--;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 16,
      children: [
        Column(
          children: [
            extra["role"] != "display"
                ? Column(
                    spacing: 8,
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
                            child: Text("-"),
                          ),
                          Text("${tellerPosisi.value}"),
                          ElevatedButton(
                            onPressed: tellerAddPosisi,
                            child: Text("+"),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
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
                  ),
          ],
        ),
        GestureDetector(
          onLongPress: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: const Center(
                  child: Text('Konfirmasi'),
                ),
                content:
                    const Text('Apakah Anda Mereset Nomor Antrian Teller?'),
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
                      tellerQueueNumber.value = 1;
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
              'A${tellerQueueNumber.value.toString().padLeft(3, '0')}',
              style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Row(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: tellerIsButtonEnabled.value
                  ? () async {
                      tellerMinPosisiAntri();
                      showDialogApp(
                        context: context,
                        title:
                            "A${tellerQueueNumber.value.toString().padLeft(3, '0')}",
                        subtitle: "Teller ${tellerPosisi.value}",
                      );

                      tellerDisableButton();
                      await tellerPlaySoundSequence(
                          ['sounds/tingtung.wav', 'sounds/nomor-urut.wav']);
                      await playtellerQueueNumber(tellerQueueNumber.value);
                      await tellerPlaySoundSequence([
                        'sounds/loket.wav',
                        'sounds/${tellerPosisi.value}.wav'
                      ]);
                      tellerEnableButton();
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
                      showDialogApp(
                        context: context,
                        title:
                            "A${tellerQueueNumber.value.toString().padLeft(3, '0')}",
                        subtitle: "Teller ${tellerPosisi.value}",
                      );
                      tellerDisableButton();
                      await tellerPlaySoundSequence(
                          ['sounds/diulangi.wav', 'sounds/nomor-urut.wav']);
                      await playtellerQueueNumber(tellerQueueNumber.value);
                      await tellerPlaySoundSequence([
                        'sounds/loket.wav',
                        'sounds/${tellerPosisi.value}.wav'
                      ]);
                      tellerEnableButton();
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
                      tellerQueueNumber.value++;
                      showDialogApp(
                        context: context,
                        title:
                            "A${tellerQueueNumber.value.toString().padLeft(3, '0')}",
                        subtitle: "Teller ${tellerPosisi.value}",
                      );
                      tellerDisableButton();
                      await tellerPlaySoundSequence(
                          ['sounds/tingtung.wav', 'sounds/nomor-urut.wav']);
                      await playtellerQueueNumber(tellerQueueNumber.value);
                      await tellerPlaySoundSequence([
                        'sounds/loket.wav',
                        'sounds/${tellerPosisi.value}.wav'
                      ]);
                      tellerEnableButton();
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
