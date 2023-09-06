import 'package:company_manager_client/pages/settings_page.dart';
import 'package:company_manager_client/pages/users_managment_page.dart';
import 'package:flutter/material.dart';

class Constants {

  //app name
  static const appName="Santa Venere";

  //pages
  static const pages = [
    UserManagmentPage(),
    Center(child: Text("2°"),),
    Center(child: Text("3°"),),
    Center(child: Text("4°"),),
    SettingsPage(),
  ];

}