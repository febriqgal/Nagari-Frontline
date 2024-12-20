import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../shared/widgets/show_dialog_app.dart';

class CsView extends HookConsumerWidget {
  CsView({super.key, required audioCache});

  final audioCache = AudioPlayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final csIsButtonEnabled = useState(true);
    final csQueueNumber = useState(9);
    final csPosisi = useState(1);
    final Map<String, dynamic> extra =
        GoRouterState.of(context).extra as Map<String, dynamic>;
    Future<void> csPlaySoundSequence(List<String> soundFiles) async {
      for (var sound in soundFiles) {
        await audioCache.play(AssetSource(sound));
        await audioCache.onPlayerComplete.first;
      }
    }

    Future<List<String>> csGetNumberSounds(int number) async {
      List<String> sounds = [];
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

    Future<void> playCSQueueNumber(int number) async {
      List<String> sounds = ['sounds/b.wav'];
      if (number <= 10) {
        sounds.add('sounds/$number.wav');
      } else if (number == 10) {
        sounds.add('sounds/sepuluh.wav');
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
          sounds.addAll(await csGetNumberSounds(number - 100));
        }
      } else if (number < 300) {
        sounds.add('sounds/200.wav');
        if (number > 200) {
          sounds.addAll(await csGetNumberSounds(number - 200));
        }
      } else if (number < 400) {
        sounds.add('sounds/300.wav');
        if (number > 300) {
          sounds.addAll(await csGetNumberSounds(number - 300));
        }
      } else if (number < 500) {
        sounds.add('sounds/400.wav');
        if (number > 400) {
          sounds.addAll(await csGetNumberSounds(number - 400));
        }
      } else if (number < 600) {
        sounds.add('sounds/500.wav');
        if (number > 500) {
          sounds.addAll(await csGetNumberSounds(number - 500));
        }
      } else if (number < 700) {
        sounds.add('sounds/600.wav');
        if (number > 600) {
          sounds.addAll(await csGetNumberSounds(number - 600));
        }
      } else if (number < 800) {
        sounds.add('sounds/700.wav');
        if (number > 700) {
          sounds.addAll(await csGetNumberSounds(number - 700));
        }
      } else if (number < 900) {
        sounds.add('sounds/800.wav');
        if (number > 800) {
          sounds.addAll(await csGetNumberSounds(number - 800));
        }
      } else if (number < 1000) {
        sounds.add('sounds/900.wav');
        if (number > 900) {
          sounds.addAll(await csGetNumberSounds(number - 900));
        }
      }
      await csPlaySoundSequence(sounds);
    }

    void csDisableButton() => csIsButtonEnabled.value = false;
    void csEnableButton() {
      csIsButtonEnabled.value = true;
      Navigator.of(context).pop();
    }

    void csAddPosisi() {
      if (csPosisi.value < 9) csPosisi.value++;
    }

    void csMinPosisiAntri() {
      if (csQueueNumber.value > 1) csQueueNumber.value--;
    }

    void csMinPosisi() {
      if (csPosisi.value > 1) csPosisi.value--;
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
                        'Customer Service',
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
                            onPressed: csMinPosisi,
                            child: Text("-"),
                          ),
                          Text("${csPosisi.value}"),
                          ElevatedButton(
                            onPressed: csAddPosisi,
                            child: Text("+"),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
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
              'B${csQueueNumber.value.toString().padLeft(3, '0')}',
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
              onPressed: csIsButtonEnabled.value
                  ? () async {
                      csMinPosisiAntri();
                      showDialogApp(
                        context: context,
                        title:
                            "B${csQueueNumber.value.toString().padLeft(3, '0')}",
                        subtitle: "CS ${csPosisi.value}",
                      );

                      csDisableButton();
                      await csPlaySoundSequence(
                          ['sounds/tingtung.wav', 'sounds/nomor-urut.wav']);
                      await playCSQueueNumber(csQueueNumber.value);
                      await csPlaySoundSequence([
                        'sounds/loket-cs.wav',
                        'sounds/${csPosisi.value}.wav'
                      ]);
                      csEnableButton();
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
                      showDialogApp(
                        context: context,
                        title:
                            "B${csQueueNumber.value.toString().padLeft(3, '0')}",
                        subtitle: "CS ${csPosisi.value}",
                      );
                      csDisableButton();
                      await csPlaySoundSequence(
                          ['sounds/diulangi.wav', 'sounds/nomor-urut.wav']);
                      await playCSQueueNumber(csQueueNumber.value);
                      await csPlaySoundSequence([
                        'sounds/loket-cs.wav',
                        'sounds/${csPosisi.value}.wav'
                      ]);
                      csEnableButton();
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
                      showDialogApp(
                        context: context,
                        title:
                            "B${csQueueNumber.value.toString().padLeft(3, '0')}",
                        subtitle: "CS ${csPosisi.value}",
                      );
                      csDisableButton();
                      await csPlaySoundSequence(
                          ['sounds/tingtung.wav', 'sounds/nomor-urut.wav']);
                      await playCSQueueNumber(csQueueNumber.value);
                      await csPlaySoundSequence([
                        'sounds/loket-cs.wav',
                        'sounds/${csPosisi.value}.wav'
                      ]);
                      csEnableButton();
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
