import 'package:company_manager_client/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MyLogo extends ConsumerWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme=ref.watch(isDarkThemeProvider);

    return isDarkTheme ? 
      Image.asset("lib/images/light_logo_no_bg.png") 
      : 
      Image.asset("lib/images/dark_logo_no_bg.png");
  }
}