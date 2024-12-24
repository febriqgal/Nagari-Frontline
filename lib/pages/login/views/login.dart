import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nagarifrontline/pages/login/widgets/form_login.dart';
import 'package:nagarifrontline/providers/kantor/kantor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends HookConsumerWidget {
  static const bool isRoot = true;
  static const String name = "login";
  static String get path => isRoot ? '/$name' : name;

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(kantorProvider);
    final asyncPrefs = SharedPreferencesAsync();
    final stateCount = useState<int>(0);
    final ipC = useTextEditingController();
    final namaCabang = useTextEditingController();
    final isLoading = useState<bool>(false);

    useEffect(() {
      () async {
        final action = await asyncPrefs.getString('ip');
        if (action != null) {
          ipC.text = action;
        }
      }();
      return null;
    }, []);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/c.png",
                height: MediaQuery.of(context).size.height * 0.9,
              ),
              FormLogin(
                namaCabang: namaCabang,
                res: res,
                ipC: ipC,
                stateCount: stateCount,
                isLoading: isLoading,
                asyncPrefs: asyncPrefs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
