import 'package:flutter/material.dart';

class BarCode extends StatelessWidget {
  const BarCode({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Login with bar-code', style: TextStyle(fontSize: 20.0),)
      ),
      content: SizedBox(
        height: 150.0,
        width: 200.0,
        child: Image.asset("lib/images/bar_code.png"),
      ),
    );
  }
}