import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/change_password_form.dart';
import 'package:company_manager_client/widgets/my_app_bar.dart';
import 'package:company_manager_client/widgets/print_card_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final isDarkTheme=ref.watch(isDarkThemeProvider);
    final appLocalization=ref.watch(AppLocalizations.providers);

    final changePasswordTile=GestureDetector(
      onTap: () => showDialog(
        context: context, 
        builder: (BuildContext context) => const ChangePasswordForm(),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Iconsax.lock),
              const SizedBox(height: 10.0,),
              Text(appLocalization.changePassword!, style: const TextStyle(fontSize: 20.0),),
            ],
          ),
        ),
      ),
    );

    final printCardTile=GestureDetector(
      onTap: () => showDialog(
        context: context, 
        builder: (BuildContext context) => const PrintCardForm(),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Iconsax.printer),
              const SizedBox(height: 10.0,),
              Text(appLocalization.printCard!, style: const TextStyle(fontSize: 20.0),),
            ],
          ),
        ),
      ),
    );

    return Scaffold(

      appBar: const MyAppBar(),

      body: ResponsiveLayout.isMobile(context) ? 
        SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              changePasswordTile,
              const SizedBox(height: 20.0,),
              printCardTile,
            ],
          ),
        )
        :
        SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 230.0,
                child: changePasswordTile
              ),
              const SizedBox(width: 20.0,),
              SizedBox(
                width: 230.0,
                child: printCardTile
              ),
            ],
          ),
        )

    );
  }
}