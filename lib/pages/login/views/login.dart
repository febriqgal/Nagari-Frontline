import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nagarifrontline/pages/home/views/home.dart';
import 'package:nagarifrontline/pages/login/widgets/text_field_app.dart';
import 'package:nagarifrontline/providers/ping/ping.dart';
import 'package:nagarifrontline/widgets/button_with_background_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends HookConsumerWidget {
  static const bool isRoot = true;
  static const String name = "login";
  static String get path => isRoot ? '/$name' : name;
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    final ValueNotifier<int> stateCount = useState<int>(0);
    final TextEditingController controller = useTextEditingController();
    useEffect(() {
      () async {
        final String? action = await asyncPrefs.getString('ip');
        if (action != null) {
          controller.text = action;
        }
      }();
      return null;
    }, []);
    final isLoading = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldApp(
                maxLength: 20,
                controller: controller,
                stateCount: stateCount,
                title: "Masukkan IP Address",
                keyboardType: TextInputType.url,
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedCellularNetwork,
                  color: Colors.blue,
                  size: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "*example: 192.0.18.21:3000",
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: 10,
                  ),
                ),
              ),
              Gap(8),
              ButtonWithBackgroundImageApp(
                label: isLoading.value
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Cek Koneksi",
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () async {
                  isLoading.value = true;
                  final ss = await ref.read(
                      pingProvider(url: "http://${controller.text}").future);
                  log(ss);
                  if (!ss.contains("error")) {
                    if (context.mounted) {
                      await asyncPrefs.setString('ip', controller.text);
                      if (context.mounted) {
                        context.goNamed(HomePage.name);
                      }
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.blue,
                          content: Text("Koneksi Gagal"),
                        ),
                      );
                    }
                  }
                  isLoading.value = false;
                },
              ),
              Gap(8),
            ],
          ),
        ),
      ),
    );
  }
}
