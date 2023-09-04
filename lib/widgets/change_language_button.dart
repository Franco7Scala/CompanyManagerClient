import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('it'));
final selectedPopUpMenuProvider=StateProvider<int>((ref) => 0);

class ChangeLanguageButton extends ConsumerWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPopUpMenu=ref.watch(selectedPopUpMenuProvider);
    final appLocalization=ref.watch(AppLocalizations.providers); 

    return PopupMenuButton(
      icon: const Icon(Iconsax.global),
      initialValue: selectedPopUpMenu,
      position: PopupMenuPosition.under,
      offset: const Offset(0, 10.0),
      tooltip: appLocalization.changeLanguage,
      // Callback that sets the selected popup menu item.
      onSelected: (index) {
        ref.read(selectedPopUpMenuProvider.notifier).state=selectedPopUpMenu;
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          onTap: () => ref.read(localeProvider.notifier).state=const Locale("it"),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 35.0,
                child: Image.asset("lib/images/italy.png")
              ),
              const SizedBox(width: 15.0,),
              const Text("Italiano")
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () => ref.read(localeProvider.notifier).state=const Locale("en"),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 35.0,
                child: Image.asset("lib/images/united-kingdom.png")
              ),
              const SizedBox(width: 15.0,),
              const Text("English")
            ],
          ),
        ),
      ],
    );
  }
}


/*
InkWell(
      onTap: () {
        if(locale == const Locale("it")){
          ref.read(localeProvider.notifier).state=const Locale("en");
        }
        else {
          ref.read(localeProvider.notifier).state=const Locale("it");
        }
      }, 
      child: locale == const Locale("it") ? 
        SizedBox(
          height: 35.0,
          child: Image.asset("lib/images/italy.png")
        ) 
        : 
        SizedBox(
          height: 35.0,
          child: Image.asset("lib/images/united-kingdom.png")
        ),
    );
*/