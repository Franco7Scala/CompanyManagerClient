import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/change_language_button.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static final providers = Provider<AppLocalizations>((ref) {
    final locale = ref.watch(localeProvider);
    return AppLocalizations(locale);
  });

  // metodi per ottenere le traduzioni
  String? get login => _localizedValues[locale.languageCode]?['login'];
  String? get signIn => _localizedValues[locale.languageCode]?['signIn'];
  String? get loginWithBarCode => _localizedValues[locale.languageCode]?['loginWithBarCode'];
  String? get typeYourUsername => _localizedValues[locale.languageCode]?['typeYourUsername'];
  String? get typeYourPassword => _localizedValues[locale.languageCode]?['typeYourPassword'];
  String? get firstName => _localizedValues[locale.languageCode]?['firstName'];
  String? get lastName => _localizedValues[locale.languageCode]?['lastName'];
  String? get changeLanguage => _localizedValues[locale.languageCode]?['changeLanguage'];
  String? get notRegisteredYet => _localizedValues[locale.languageCode]?['notRegisteredYet'];
  String? get users => _localizedValues[locale.languageCode]?['users'];
  String? get workShift => _localizedValues[locale.languageCode]?['workShift'];
  String? get warehouse => _localizedValues[locale.languageCode]?['warehouse'];
  String? get material => _localizedValues[locale.languageCode]?['material'];
  String? get settings => _localizedValues[locale.languageCode]?['settings'];
  String? get usersManagment => _localizedValues[locale.languageCode]?['usersManagment'];
  String? get workShiftManagment => _localizedValues[locale.languageCode]?['workShiftManagment'];
  String? get warehouseManagment => _localizedValues[locale.languageCode]?['warehouseManagment'];
  String? get stuffManagment => _localizedValues[locale.languageCode]?['stuffManagment'];
  String? get logout => _localizedValues[locale.languageCode]?['logout'];
  String? get changePassword => _localizedValues[locale.languageCode]?['changePassword'];
  String? get printCard => _localizedValues[locale.languageCode]?['printCard'];
  String? get oldPassword => _localizedValues[locale.languageCode]?['oldPassword'];
  String? get newPassword => _localizedValues[locale.languageCode]?['newPassword'];
  String? get save => _localizedValues[locale.languageCode]?['save'];
  String? get print => _localizedValues[locale.languageCode]?['print'];
  String? get showUsers => _localizedValues[locale.languageCode]?['showUsers'];
  String? get hideUsers => _localizedValues[locale.languageCode]?['hideUsers'];
  String? get addUser => _localizedValues[locale.languageCode]?['addUser'];
  String? get edit => _localizedValues[locale.languageCode]?['edit'];
  String? get delete => _localizedValues[locale.languageCode]?['delete'];
  String? get code => _localizedValues[locale.languageCode]?['code'];
  String? get dailyWage => _localizedValues[locale.languageCode]?['dailyWage'];
  String? get cancel => _localizedValues[locale.languageCode]?['cancel'];
  String? get capacity => _localizedValues[locale.languageCode]?['capacity'];
  String? get addProduct => _localizedValues[locale.languageCode]?['addProduct'];
  String? get addStuffs => _localizedValues[locale.languageCode]?['addStuffs'];
  String? get products => _localizedValues[locale.languageCode]?['products'];
  String? get stuffs => _localizedValues[locale.languageCode]?['stuffs'];
  String? get addCapacity => _localizedValues[locale.languageCode]?['addCapacity'];
  String? get editUser => _localizedValues[locale.languageCode]?['editUser'];
  String? get deleteUser => _localizedValues[locale.languageCode]?['deleteUser'];
  

  // mapping delle traduzioni
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'login': 'Login',
      'signIn' : 'Sign in',
      'loginWithBarCode': "Login with bar-code",
      'typeYourUsername': "Type your username",
      'typeYourPassword': "Type your password",
      'firstName': "First name",
      'lastName': "Last name",
      'changeLanguage': "Change language",
      'notRegisteredYet': "Not registered yet?",
      'users': 'Users',
      'workShift': 'Work shift',
      'warehouse': 'Warehouse',
      'material': 'Material',
      'settings': 'Settings',
      'usersManagment': 'Users managment',
      'workShiftManagment': 'Work shift managment',
      'warehouseManagment': 'Warehouse managment',
      'stuffManagment': 'Stuff managment',
      'logout': 'Logout',
      'changePassword': 'Change password',
      'printCard': 'Print card',
      'oldPassword': 'Old password',
      'newPassword': 'New password',
      'save' : 'Save',
      'print' : 'Print',
      'showUsers' : 'Show users',
      'hideUsers' : 'Hide users',
      'addUser': 'Add user',
      "edit": 'Edit',
      "delete": 'Delete',
      'code' : 'Code',
      'dailyWage' : 'Daily wage',
      'cancel' : 'Cancel',
      'capacity': 'Capacity',
      'addProduct': 'Add product',
      'addStuffs': 'Add stuffs',
      'products': 'Products',
      'stuffs': 'Stuffs',
      'addCapacity': 'Add capacity',
      'editUser': 'Edit user',
      'deleteUser': 'Delete user',
    },
    'it': {
      'login': 'Accedi',
      'signIn' : 'Registrati',
      'loginWithBarCode': "Accedi con bar-code",
      'typeYourUsername': "Inserisci il tuo username",
      'typeYourPassword': "Inserisci la tua password",
      'firstName': "Nome",
      'lastName': "Cognome",
      'changeLanguage': "Cambia lingua",
      'notRegisteredYet': "Non sei ancora registrato?",
      'users': 'Utenti',
      'workShift': 'Turni di lavoro',
      'warehouse': 'Magazzino',
      'material': 'Materiale',
      'settings': 'Impostazioni',
      'usersManagment': 'Gestione utenti',
      'workShiftManagment': 'Gestione turni di lavoro',
      'warehouseManagment': 'Gestione magazzino',
      'stuffManagment': 'Gestione materiale',
      'logout': "Esci",
      'changePassword': 'Cambia password',
      'printCard': 'Stampa tessera',
      'oldPassword': 'Vecchia password',
      'newPassword': 'Nuova password',
      'save' : 'Salva',
      'print' : 'Stampa',
      'showUsers' : 'Visualizza utenti',
      'hideUsers' : 'Nascondi utenti',
      'addUser': 'Aggiungi utente',
      "edit": 'Modifica',
      "delete": 'Elimina',
      'code' : 'Codice',
      'dailyWage' : 'Salario giornaliero',
      'cancel' : 'Annulla',
      'capacity': 'Capacità',
      'addProduct': 'Aggiungi prodotto',
      'addStuffs': 'Aggiungi materiale',
      'products': 'Prodotti',
      'stuffs': 'Materiali',
      'addCapacity': 'Aggiungi capacità',
      'editUser': 'Modifica utente',
      'deleteUser': 'Elimina utente',
    },
    // Aggiungi altre lingue qui...
  };
}
