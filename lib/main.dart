import 'package:company_manager_client/pages/dashboard_page.dart';
//import 'package:company_manager_client/pages/initial_page.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/themes.dart';
import 'package:company_manager_client/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme=ref.watch(isDarkThemeProvider);

    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: Themes.myThemeData(isDarkTheme),
      //home: const InitialPage(),
      home: const DashboardPage(),
    );
  }
}
