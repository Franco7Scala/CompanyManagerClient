import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarCode extends ConsumerWidget {
  const BarCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return AlertDialog(
      title: Center(
        child: Text(appLocalization.loginWithBarCode!, style: const TextStyle(fontSize: 20.0),)
      ),
      content: SizedBox(
        height: 150.0,
        width: 200.0,
        child: Image.asset("lib/images/bar_code.png"),
      ),
    );
  }
}