import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

Future<dynamic> showModalBottomSheetApp({
  required BuildContext context,
  required Widget title,
  Widget? subTitle,
  void Function()? clear,
  required double height,
  double? maxHeight,
  required Widget child,
}) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    isDismissible: true,
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    context: context,
    builder: (context) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (clear != null) {
            clear();
          }
        }
      },
      child: DraggableScrollableSheet(
        initialChildSize: height, // 50% of the screen height
        minChildSize: height, // Minimum height
        maxChildSize: maxHeight ?? height, // Maximum height
        snap: true,
        expand: false,
        builder: (context, scrollController) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title,
                              subTitle ?? Container(),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedCancel01,
                              color: Colors.black,
                              size: 24.0,
                            )),
                      ],
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: SingleChildScrollView(
                      // primary: true,
                      controller: scrollController,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
