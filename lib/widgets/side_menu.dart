import 'package:company_manager_client/pages/dashboard_page.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';


class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex=ref.watch(selectedIndexProvider);
    final appLocalization=ref.watch(AppLocalizations.providers);
    final isDarkTheme=ref.watch(isDarkThemeProvider);

    return NavigationRail(
      elevation: 10.0,
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        ref.read(selectedIndexProvider.notifier).state=index;
      },
      labelType: ResponsiveLayout.isTablet(context) ? NavigationRailLabelType.all : null,
      groupAlignment: -1,
      extended: !ResponsiveLayout.isTablet(context) ? true : false,
      leading: ResponsiveLayout.isTablet(context) ? 
        SizedBox(
          height: 98.0,
          width: 98.0,
          child: isDarkTheme ? 
            Image.asset("lib/images/light_icon_logo_no_bg.png")
            :
            Image.asset("lib/images/dark_icon_logo_no_bg.png"),
        ) 
        :
        SizedBox(
          //height: 150.0,
          //width: 150.0,
          child: isDarkTheme ? 
            Image.asset("lib/images/light_logo_no_bg.png")
            :
            Image.asset("lib/images/dark_logo_no_bg.png")
        ),
      /*
      trailing: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveLayout.isTablet(context) ? 
              SizedBox(
                height: 98.0,
                width: 98.0,
                child: isDarkTheme ? 
                  const Image(image: AssetImage("./assets/images/light_icon_logo_no_bg.png"),)
                  :
                  const Image(image: AssetImage("./assets/images/dark_icon_logo_no_bg.png"),)
              ) 
              :
              SizedBox(
                //height: 150.0,
                //width: 150.0,
                child: isDarkTheme ? 
                  const Image(image: AssetImage("./assets/images/light_logo_no_bg.png"),)
                  :
                  const Image(image: AssetImage("./assets/images/dark_logo_no_bg.png"),)
              ),
          ),
        ),
      ),
      */
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          padding: const EdgeInsets.only(top: 20.0),
          icon: const Icon(Iconsax.profile_2user),
          selectedIcon: const Icon(Iconsax.profile_2user),
          label: Text(appLocalization.users!),
        ),
        NavigationRailDestination(
          icon: const Icon(Iconsax.people),
          selectedIcon: const Icon(Iconsax.people),
          label: Text(appLocalization.workShift!),
        ),
        NavigationRailDestination(
          icon: const Icon(Iconsax.shopping_cart),
          selectedIcon: const Icon(Iconsax.shopping_cart),
          label: Text(appLocalization.warehouse!),
        ),
        NavigationRailDestination(
          icon: const Icon(Iconsax.box),
          selectedIcon: const Icon(Iconsax.box),
          label: Text(appLocalization.material!),
        ),
        NavigationRailDestination(
          icon: const Icon(Iconsax.setting_2),
          selectedIcon: const Icon(Iconsax.setting_2),
          label: Text(appLocalization.settings!),
        ),
      ],
    );
  }
}

