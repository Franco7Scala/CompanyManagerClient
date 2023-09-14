import 'package:company_manager_client/pages/settings_page.dart';
import 'package:company_manager_client/pages/stuffs_managment_page.dart';
import 'package:company_manager_client/pages/users_managment_page.dart';
import 'package:company_manager_client/pages/warehouse_managment_page.dart';
import 'package:company_manager_client/pages/work_shift_managment_page.dart';

class Constants {

  //app name
  static const appName="Santa Venere";

  //pages
  static const pages = [
    UserManagmentPage(),
    WorkShiftManagmentPage(),
    WarehouseManagmentPage(),
    StuffsManagmentPage(),
    SettingsPage(),
  ];

  //base url
  static const String baseUrl='http://localhost:8080/api';

}