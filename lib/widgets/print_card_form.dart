import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class PrintCardForm extends ConsumerStatefulWidget {
  const PrintCardForm({super.key});

  @override
  PrintCardFormState createState() => PrintCardFormState();
}

class PrintCardFormState extends ConsumerState<PrintCardForm> {
  bool _hidePassword = true;
  final _passwordController = TextEditingController();
  bool _isTyping = false;

   @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isTyping = _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onTextChanged);
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return AlertDialog(
      title: Column(
        children: <Widget>[
          Icon(Iconsax.printer, size: !ResponsiveLayout.isMobile(context) ? 30.0 : null,),
          const SizedBox(height: 7.0,),
          Text(
            appLocalization.printCard!, 
            style: TextStyle(
              fontSize: !ResponsiveLayout.isMobile(context) ? 30.0 : null,
            ),
          ),
        ],
      ),
      scrollable: true,
      content: SizedBox(
        width: !ResponsiveLayout.isMobile(context) ? 400.0 : 270.0,
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10.0,),

              TextField(
                controller: _passwordController,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.typeYourPassword,
                  suffixIcon: _isTyping
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      iconSize: 22.0,
                      icon: Icon(
                          _hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                    )
                    : 
                    null,
                ),
              ),
              const SizedBox(height: 20.0,),
              
             TextButton(
                onPressed: () {        },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                ),
                child: Text(appLocalization.print!),
              ),
                
            ],
          ),
        ),
      ),
    );
  }
}