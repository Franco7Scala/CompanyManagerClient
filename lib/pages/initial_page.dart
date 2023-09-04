import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/change_language_button.dart';
import 'package:company_manager_client/widgets/change_theme_button.dart';
import 'package:company_manager_client/widgets/login_button.dart';
import 'package:company_manager_client/widgets/my_logo.dart';
import 'package:company_manager_client/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialPage extends ConsumerWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return Scaffold(

      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: <Widget>[
          //change theme button always visible
          const ChangeThemeButton(),

          //divider always visible
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: VerticalDivider(indent: 15.0, endIndent: 15.0,),
          ),

          //change language button always visible
          const ChangeLanguageButton(),

          //divider
          Visibility(
            visible: !ResponsiveLayout.isMobile(context) ? true : false,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: VerticalDivider(indent: 15.0, endIndent: 15.0,),
            ),
          ),

          //login button visible only tablet or desktop layout
          Visibility(
            visible: !ResponsiveLayout.isMobile(context) ? true : false,
            child: const LoginButton(),
          ),

          //divider
          Visibility(
            visible: !ResponsiveLayout.isMobile(context) ? true : false,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: VerticalDivider(indent: 15.0, endIndent: 15.0,),
            ),
          ),

          //sign in button visible only tablet or desktop layout
          Visibility(
            visible: !ResponsiveLayout.isMobile(context) ? true : false,
            child: const SignInButton(),
          ),

          //right padding always visible
          const Padding(padding: EdgeInsets.only(right: 15.0)),
        ],
      ),

      body: ResponsiveLayout(
        
        //mobile layout
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const MyLogo(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const LoginButton(),
                  const SizedBox(height: 5.0,),
                  const Divider(
                    indent: 40.0,
                    endIndent: 40.0,
                  ),
                  const SizedBox(height: 5.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(appLocalization.notRegisteredYet!),
                      const SizedBox(width: 10.0,),
                      const SignInButton(),
                    ],
                  ),
                ],
              ),
            )  
          ],
        ),

        //tbalet layout
        tablet: const Center(
          child: SizedBox(
            width: 900.0,
            height: 450.0,  
            child: MyLogo(),
          ),
        ),

        //desktop layout
        desktop: const Center(
          child: SizedBox(
            width: 1000.0,
            height: 500.0,  
            child: MyLogo(),
          ),
        ),
        
      ),

    );
  }
}