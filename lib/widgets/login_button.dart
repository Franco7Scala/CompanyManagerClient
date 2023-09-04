import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: const Text(" Login "),
    );
  }
}