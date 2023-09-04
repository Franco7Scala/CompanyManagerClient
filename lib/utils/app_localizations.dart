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
    },
    // Aggiungi altre lingue qui...
  };
}
