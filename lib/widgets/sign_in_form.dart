import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends ConsumerState<SignInForm> {
  final _firstNameController=TextEditingController();
  final _lastNameController=TextEditingController();
  final _usernameController=TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
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
      //contentPadding: const EdgeInsets.all(12.0),
      scrollable: true,
      content: SizedBox(
        width: !ResponsiveLayout.isMobile(context) ? 400.0 : null,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              const MyLogo(),
              const SizedBox(height: 20.0,) ,

              Text(appLocalization.signIn!, style: const TextStyle(fontSize: 20.0),),
              const SizedBox(height: 16.0,),

              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.firstName,
                ),
              ),
              const SizedBox(height: 16.0,),

              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.lastName,
                ),
              ),
              const SizedBox(height: 16.0,),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.typeYourUsername,
                ),
              ),
              const SizedBox(height: 16.0,),
              
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
                      icon: Icon(
                          _hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                    )
                    : 
                    null,
                ),
              ),
              const SizedBox(height: 16.0,),

              TextButton(
                onPressed: () {
                  
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                ),
                child: Text(appLocalization.signIn!),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

