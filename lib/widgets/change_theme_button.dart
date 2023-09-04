import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final isDarkThemeProvider=StateProvider<bool>((ref) => false);

class ChangeThemeButton extends ConsumerWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme=ref.watch(isDarkThemeProvider);

    return IconButton(
      onPressed: () {
        ref.read(isDarkThemeProvider.notifier).state=!isDarkTheme;
      },
      icon: isDarkTheme ? const Icon(Iconsax.sun_14) : const Icon(Iconsax.moon),
    );
  }
}