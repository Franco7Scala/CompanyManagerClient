import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _firstNameController=TextEditingController();
  final _lastNameController=TextEditingController();
  final _mailController=TextEditingController();
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

              const Text("Sign in", style: TextStyle(fontSize: 20.0),),
              const SizedBox(height: 16.0,),

              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Type your first name",
                ),
              ),
              const SizedBox(height: 16.0,),

              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Type your last name",
                ),
              ),
              const SizedBox(height: 16.0,),

              TextField(
                controller: _mailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Type your username",
                ),
              ),
              const SizedBox(height: 16.0,),
              
              TextField(
                controller: _passwordController,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Type your password",
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
                child: const Text("Sign in"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

