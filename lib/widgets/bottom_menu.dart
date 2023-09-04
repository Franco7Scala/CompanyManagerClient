import 'package:company_manager_client/pages/dashboard_page.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class BottomMenu extends ConsumerWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex=ref.watch(selectedIndexProvider);
    final appLocalization=ref.watch(AppLocalizations.providers);

    return NavigationBar(
       onDestinationSelected: (int index) {
          ref.read(selectedIndexProvider.notifier).state=index;
        },
        selectedIndex: selectedIndex,
        elevation: 10.0,
        destinations: <Widget>[
          NavigationDestination(
           icon: const Icon(Iconsax.profile_2user),
            selectedIcon: const Icon(Iconsax.profile_2user),
            label: appLocalization.users!,
          ),
          
          NavigationDestination(
            icon: const Icon(Iconsax.people),
            selectedIcon: const Icon(Iconsax.people),
            label: appLocalization.workShift!,
          ),
          
          NavigationDestination(
            icon: const Icon(Iconsax.shopping_cart),
            selectedIcon: const Icon(Iconsax.shopping_cart),
            label: appLocalization.warehouse!,
          ),

          NavigationDestination(
            icon: const Icon(Iconsax.box),
            selectedIcon: const Icon(Iconsax.box),
            label: appLocalization.material!,
          ),

          NavigationDestination(
            icon: const Icon(Iconsax.setting_2),
            selectedIcon: const Icon(Iconsax.setting_2),
            label: appLocalization.settings!,
          ),
          
        ],
    );
  }
}