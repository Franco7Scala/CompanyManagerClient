import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class ChangePasswordForm extends ConsumerStatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  ChangePasswordFormState createState() => ChangePasswordFormState();
}

class ChangePasswordFormState extends ConsumerState<ChangePasswordForm> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController1 = TextEditingController();
  final _newPasswordController2 = TextEditingController();
  bool _hideOldPassword = true;
  bool _hideNewPassword1 = true;
  bool _hideNewPassword2 = true;
  bool _isTypingOldP = false;
  bool _isTypingNewP1 = false;
  bool _isTypingNewP2 = false;

   @override
  void initState() {
    super.initState();
    _oldPasswordController.addListener(_onTextChanged);
    _newPasswordController1.addListener(_onTextChanged);
    _newPasswordController2.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isTypingOldP = _oldPasswordController.text.isNotEmpty;
      _isTypingNewP1 = _newPasswordController1.text.isNotEmpty;
      _isTypingNewP2 = _newPasswordController2.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _oldPasswordController.removeListener(_onTextChanged);
    _newPasswordController1.removeListener(_onTextChanged);
    _newPasswordController2.removeListener(_onTextChanged);
    _oldPasswordController.dispose();
    _newPasswordController1.dispose();
    _newPasswordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return AlertDialog(
      title: Column(
        children: <Widget>[
          Icon(Iconsax.lock, size: !ResponsiveLayout.isMobile(context) ? 30.0 : null,),
          const SizedBox(height: 7.0,),
          Text(
            appLocalization.changePassword!, 
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10.0,),

              TextField(
                obscureText: _hideOldPassword,
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.oldPassword,
                  suffixIcon: _isTypingOldP
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _hideOldPassword = !_hideOldPassword;
                        });
                      },
                      icon: Icon(
                          _hideOldPassword ? Iconsax.eye_slash : Iconsax.eye),
                    )
                    : 
                    null,
                ),
              ),
              const SizedBox(height: 20.0,),
              
              TextField(
                obscureText: _hideNewPassword1,
                controller: _newPasswordController1,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.newPassword,
                  suffixIcon: _isTypingNewP1
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _hideNewPassword1 = !_hideNewPassword1;
                        });
                      },
                      icon: Icon(
                          _hideNewPassword1 ? Iconsax.eye_slash : Iconsax.eye),
                    )
                    : 
                    null,
                ),
              ),
              const SizedBox(height: 20.0,),
              
              TextField(
                obscureText: _hideNewPassword2,
                controller: _newPasswordController2,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.newPassword,
                  suffixIcon: _isTypingNewP2
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _hideNewPassword2 = !_hideNewPassword2;
                        });
                      },
                      icon: Icon(
                          _hideNewPassword2 ? Iconsax.eye_slash : Iconsax.eye),
                    )
                    : 
                    null,
                ),
              ),
              const SizedBox(height: 20.0,),
        
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                ),
                child: Text(appLocalization.save!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}