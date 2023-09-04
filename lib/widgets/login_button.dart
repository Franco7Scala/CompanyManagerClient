import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: ResponsiveLayout.isMobile(context) ?
          const EdgeInsets.only(bottom: 20.0, top: 20.0)
          : 
          const EdgeInsets.only(bottom: 15.0, top: 15.0, right: 35.0, left: 35.0),
      ),
      onPressed: () => showDialog(
        context: context, 
        builder: (BuildContext context) => const LoginForm(),
      ),
      child: Text(appLocalization.login!),
    );
  }
}