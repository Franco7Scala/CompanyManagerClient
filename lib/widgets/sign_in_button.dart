import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: !ResponsiveLayout.isMobile(context) ?
          const EdgeInsets.only(bottom: 15.0, top: 15.0, right: 35.0, left: 35.0)
          : 
          null,
      ),
      onPressed: () => showDialog(
        context: context, 
        builder: (BuildContext context) => const SignInForm(),
      ),
      child: const Text("Sign in"),
    );
  }
}