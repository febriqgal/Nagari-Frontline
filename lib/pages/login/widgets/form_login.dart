import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nagarifrontline/model/kantor/kantor.dart';
import 'package:nagarifrontline/pages/home/views/home.dart';
import 'package:nagarifrontline/pages/login/widgets/text_field_app.dart';
import 'package:nagarifrontline/providers/ping/ping.dart';
import 'package:nagarifrontline/widgets/button_with_background_image.dart';
import 'package:nagarifrontline/widgets/show_modal_bottom_sheet_app.dart';
import 'package:nagarifrontline/widgets/show_toast.dart';
import 'package:nagarifrontline/widgets/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormLogin extends HookConsumerWidget {
  const FormLogin({
    super.key,
    required this.namaCabang,
    required this.res,
    required this.ipC,
    required this.stateCount,
    required this.isLoading,
    required this.asyncPrefs,
  });

  final TextEditingController namaCabang;
  final List<KantorModel> res;
  final TextEditingController ipC;
  final ValueNotifier<int> stateCount;
  final ValueNotifier<bool> isLoading;
  final SharedPreferencesAsync asyncPrefs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo_nagari.png",
                height: 30,
              ),
              Text(
                "Nagari Frontline",
                style:
                    TextStylesApp.text2xl.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Gap(64),
          TextField(
            controller: namaCabang,
            readOnly: true,
            decoration: InputDecoration(
                hintText: "Pilih Kantor",
                prefixIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedOffice,
                  color: Colors.blue,
                  size: 24.0,
                ),
                suffixIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedSquareArrowDown01,
                  color: Colors.blue,
                  size: 20.0,
                )),
            onTap: () {
              showModalBottomSheetApp(
                title: Text(
                  "Pilih Kantor",
                  style: TextStylesApp.text2xl,
                ),
                context: context,
                height: 0.9,
                child: HookBuilder(builder: (context) {
                  final searchC = useTextEditingController();
                  final filteredRes = useState(res);

                  useEffect(() {
                    searchC.addListener(() {
                      final query = searchC.text.toLowerCase();
                      filteredRes.value = res.where((kantor) {
                        return kantor.nama.toLowerCase().contains(query) ||
                            kantor.kode.toLowerCase().contains(query) ||
                            kantor.basis.toLowerCase().contains(query);
                      }).toList();
                    });
                    return null;
                  }, [res]);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        child: TextFieldApp(
                          maxLength: 20,
                          controller: searchC,
                          title: "Cari Kantor",
                          keyboardType: TextInputType.text,
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedSearch02,
                            color: Colors.blue,
                            size: 24.0,
                          ),
                        ),
                      ),
                      ...filteredRes.value.map(
                        (e) => ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          leading: CircleAvatar(
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedOffice,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                          ),
                          title: Text(e.nama),
                          subtitle: Text.rich(
                            TextSpan(
                              text: "Kode Cab: ",
                              children: [
                                TextSpan(
                                  text: e.kode,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          trailing: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.blue.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                              child: Text(
                                e.basis,
                                style: TextStyle(color: Colors.blue),
                              )),
                          onTap: () {
                            namaCabang.text = e.nama;
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  );
                }),
              );
            },
          ),
          Gap(4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFieldApp(
                maxLength: 20,
                controller: ipC,
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
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
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
              if (namaCabang.text.isEmpty) {
                showToastWarningApp(
                    context: context, title: "Nama Cabang tidak boleh kosong");
                isLoading.value = false;
                return;
              }
              if (ipC.text.isEmpty) {
                showToastWarningApp(
                    context: context, title: "IP Address tidak boleh kosong");
                isLoading.value = false;
                return;
              }
              final ss = await ref
                  .read(pingProvider(url: "http://${ipC.text}").future);
              if (!ss.contains("error")) {
                if (context.mounted) {
                  await asyncPrefs.setString('ip', ipC.text);
                  if (context.mounted) {
                    context.goNamed(HomePage.name);
                  }
                }
              } else {
                if (context.mounted) {
                  showToastWarningApp(
                    context: context,
                    title: "Koneksi Gagal, Silahkan Cek IP Address!",
                  );
                }
              }
              isLoading.value = false;
            },
          ),
          Gap(8),
        ],
      ),
    );
  }
}
