import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nagarifrontline/pages/home/views/home.dart';
import 'package:nagarifrontline/pages/login/widgets/text_field_app.dart';
import 'package:nagarifrontline/widgets/button_with_background_image.dart';

class LoginPage extends HookConsumerWidget {
  static const bool isRoot = true;
  static const String name = "login";
  static String get path => isRoot ? '/$name' : name;
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<int> stateCount = useState<int>(0);
    final TextEditingController controller = useTextEditingController();
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
                  "*example: 192.0.18.21:8080",
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: 10,
                  ),
                ),
              ),
              Gap(8),
              ButtonWithBackgroundImageApp(
                label: "Masuk",
                onPressed: () {
                  context.goNamed(HomePage.name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
