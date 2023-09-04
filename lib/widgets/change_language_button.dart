import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {}, 
      icon: const Icon(Iconsax.global)
    );
  }
}