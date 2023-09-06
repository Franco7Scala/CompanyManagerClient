import 'package:company_manager_client/pages/dashboard_page.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/change_language_button.dart';
import 'package:company_manager_client/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80.0); //kToolbarHeight

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex=ref.watch(selectedIndexProvider);
    final appLocalization=ref.watch(AppLocalizations.providers);

    final destinationName=[
      appLocalization.usersManagment,
      appLocalization.workShiftManagment,
      appLocalization.warehouseManagment,
      appLocalization.stuffManagment,
      appLocalization.settings,
    ];

    return AppBar(
      elevation: 0,
      title: Padding(
        padding: !ResponsiveLayout.isMobile(context) ? const EdgeInsets.only(left: 15.0) : const EdgeInsets.only(left: 0),
        child: Text(
          destinationName[selectedIndex]!,
          style: TextStyle(
            fontSize: !ResponsiveLayout.isMobile(context) ? 30.0 : null,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      toolbarHeight: !ResponsiveLayout.isMobile(context) ? 80.0 : null,
      actions: <Widget>[
        Visibility(
          visible: selectedIndex==4,
          child: const ChangeThemeButton(),
        ),
        Visibility(
          visible: selectedIndex==4,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: VerticalDivider(
              indent: !ResponsiveLayout.isMobile(context) ? 20.0 : 15.0, 
              endIndent: !ResponsiveLayout.isMobile(context) ? 20.0 : 15.0, 
            ),
          ),
        ),
        Visibility(
          visible: selectedIndex==4,
          child: const ChangeLanguageButton(),
        ),
        Visibility(
          visible: selectedIndex==4,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: VerticalDivider(
              indent: !ResponsiveLayout.isMobile(context) ? 20.0 : 15.0, 
              endIndent: !ResponsiveLayout.isMobile(context) ? 20.0 : 15.0,
            ),
          ),
        ),
        Visibility(
          visible: selectedIndex==4,
          child: IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Iconsax.logout),
            tooltip: appLocalization.logout!,
          ),
        ),
        Visibility(
          visible: selectedIndex==4,
          child: const Padding(
            padding: EdgeInsets.only(right:15.0),
          ),
        )
      ],
    );
  }

}