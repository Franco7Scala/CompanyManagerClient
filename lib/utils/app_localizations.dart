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
  String? get salaryPerDay => _localizedValues[locale.languageCode]?['salaryPerDay'];
  String? get cancel => _localizedValues[locale.languageCode]?['cancel'];
  String? get capability => _localizedValues[locale.languageCode]?['capability'];
  String? get addProduct => _localizedValues[locale.languageCode]?['addProduct'];
  String? get addStuffs => _localizedValues[locale.languageCode]?['addStuffs'];
  String? get products => _localizedValues[locale.languageCode]?['products'];
  String? get stuffs => _localizedValues[locale.languageCode]?['stuffs'];
  String? get addCapability => _localizedValues[locale.languageCode]?['addCapability'];
  String? get editUser => _localizedValues[locale.languageCode]?['editUser'];
  String? get deleteUser => _localizedValues[locale.languageCode]?['deleteUser'];
  String? get showCalendar => _localizedValues[locale.languageCode]?['showCalendar'];
  String? get daysThisMonth => _localizedValues[locale.languageCode]?['daysThisMonth'];
  String? get daysPreviousMonth => _localizedValues[locale.languageCode]?['daysPreviousMonth'];
  String? get addDay => _localizedValues[locale.languageCode]?['addDay'];
  String? get day => _localizedValues[locale.languageCode]?['day']; 
  String? get summary => _localizedValues[locale.languageCode]?['summary']; 
  String? get month => _localizedValues[locale.languageCode]?['month'];
  String? get thisMonth => _localizedValues[locale.languageCode]?['thisMonth'];
  String? get previousMonth => _localizedValues[locale.languageCode]?['previousMonth']; 
  String? get days => _localizedValues[locale.languageCode]?['days'];
  String? get salary => _localizedValues[locale.languageCode]?['salary']; 
  String? get date => _localizedValues[locale.languageCode]?['date']; 
  String? get noResult => _localizedValues[locale.languageCode]?['noResult'];
  String? get product => _localizedValues[locale.languageCode]?['product']; 
  String? get movements => _localizedValues[locale.languageCode]?['movements']; 
  String? get state => _localizedValues[locale.languageCode]?['state']; 
  String? get receipts => _localizedValues[locale.languageCode]?['receipts']; 
  String? get user => _localizedValues[locale.languageCode]?['user']; 
  String? get termsOfPayment => _localizedValues[locale.languageCode]?['termsOfPayment']; 
  String? get price => _localizedValues[locale.languageCode]?['price']; 
  String? get discount => _localizedValues[locale.languageCode]?['discount']; 
  String? get amount => _localizedValues[locale.languageCode]?['amount'];
  String? get name => _localizedValues[locale.languageCode]?['name'];
  String? get favourite => _localizedValues[locale.languageCode]?['favourite']; 
  String? get addState => _localizedValues[locale.languageCode]?['addState']; 
  String? get enterTheNameOfTheState => _localizedValues[locale.languageCode]?['enterTheNameOfTheState']; 
  String? get infoStateButton => _localizedValues[locale.languageCode]?['infoStateButton']; 
  String? get info => _localizedValues[locale.languageCode]?['info']; 
  String? get quantity => _localizedValues[locale.languageCode]?['quantity']; 
  String? get from => _localizedValues[locale.languageCode]?['from'];
  String? get to => _localizedValues[locale.languageCode]?['to'];
  String? get description => _localizedValues[locale.languageCode]?['description'];
  String? get addMovement => _localizedValues[locale.languageCode]?['addMovement'];
  String? get enterReasonForUnloading => _localizedValues[locale.languageCode]?['enterReasonForUnloading'];
  String? get searchProduct => _localizedValues[locale.languageCode]?['searchProduct'];
  String? get productName => _localizedValues[locale.languageCode]?['productName'];
  String? get searchByProductName => _localizedValues[locale.languageCode]?['searchByProductName'];
  String? get infoMovementButton => _localizedValues[locale.languageCode]?['infoMovementButton'];
  String? get confirm => _localizedValues[locale.languageCode]?['confirm'];
  String? get readyForUnloading => _localizedValues[locale.languageCode]?['readyForUnloading'];
  String? get year => _localizedValues[locale.languageCode]?['year'];
  String? get boxes => _localizedValues[locale.languageCode]?['boxes'];
  String? get bottles => _localizedValues[locale.languageCode]?['bottles'];
  String? get priceForPrivate => _localizedValues[locale.languageCode]?['priceForPrivate'];
  String? get pricePerReseller => _localizedValues[locale.languageCode]?['pricePerReseller'];
  String? get singleBarcode => _localizedValues[locale.languageCode]?['singleBarcode'];
  String? get packageBarcode => _localizedValues[locale.languageCode]?['packageBarcode'];
  String? get addYear => _localizedValues[locale.languageCode]?['addYear'];
  String? get search => _localizedValues[locale.languageCode]?['search'];
  String? get searchAll => _localizedValues[locale.languageCode]?['searchAll'];
  String? get or => _localizedValues[locale.languageCode]?['or'];
  String? get available => _localizedValues[locale.languageCode]?['available'];
  String? get searchStuff => _localizedValues[locale.languageCode]?['searchStuff'];
  String? get thresholdForWarning => _localizedValues[locale.languageCode]?['thresholdForWarning'];
  String? get searchStuffByName => _localizedValues[locale.languageCode]?['searchStuffByName'];
  String? get addStuff => _localizedValues[locale.languageCode]?['addStuff'];
  String? get unitOfMeasure => _localizedValues[locale.languageCode]?['unitOfMeasure'];
  String? get infoAddStuffButton => _localizedValues[locale.languageCode]?['infoAddStuffButton'];
  String? get stuff => _localizedValues[locale.languageCode]?['stuff'];
  String? get type => _localizedValues[locale.languageCode]?['type'];
  String? get unload => _localizedValues[locale.languageCode]?['unload'];
  String? get load => _localizedValues[locale.languageCode]?['load'];
  String? get infoAddMovementStuffButton => _localizedValues[locale.languageCode]?['infoAddMovementStuffButton'];
  String? get doYouWantToRemove => _localizedValues[locale.languageCode]?['doYouWantToRemove'];
  String? get fieldCannotEmpty => _localizedValues[locale.languageCode]?['fieldCannotEmpty'];
  

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
      'salaryPerDay' : 'Salary per day',
      'cancel' : 'Cancel',
      'capability': 'Capability',
      'addProduct': 'Add product',
      'addStuffs': 'Add stuffs',
      'products': 'Products',
      'stuffs': 'Stuffs',
      'addCapability': 'Add capability',
      'editUser': 'Edit user',
      'deleteUser': 'Delete user',
      'showCalendar': 'Show calendar',
      'daysThisMonth': 'Days this month',
      'daysPreviousMonth': 'Days previous month',
      'addDay': 'Add days',  
      'day': 'Day', 
      'summary': 'Summary',
      'month': 'Month', 
      'thisMonth': 'This month',  
      'previousMonth': 'Previous month', 
      'days': 'Days', 
      'salary': 'Salary',   
      'date': 'Date', 
      'noResult': 'No result', 
      'product': 'Products', 
      'movements': 'Movements', 
      'state': 'State', 
      'receipts': 'Receipts', 
      'user': 'User', 
      'termsOfPayment': 'Terms of payment', 
      'price': 'Price', 
      'discount': 'Discount', 
      'amount': 'Amount', 
      'name': 'Name',
      'favourite': 'Favourite',
      'addState': 'Add state',
      'enterTheNameOfTheState': 'Enter the name of the state',
      'infoStateButton': 'In this panel you can create, edit and remove states of the products, the favorite will come displayed when you search of products, if you brand a state you mark it as "downloadable" (therefore the third little icon) who has the viewing permission only and product unloading can be used products in this state only for I unload.',
      'info': 'Information',
      'quantity': 'Quantity',
      'from': 'From',
      'to': 'To',
      'description': 'Description',
      'addMovement': 'Add movement',
      'enterReasonForUnloading': 'Enter reason for unloading',
      'searchProduct': 'Search product',
      'productName': 'Name of product',
      'searchByProductName': "Name of the product to search for",
      'infoMovementButton': 'In this panel you can change the status of the products, enter the motivation and then look for the products to download by writing your initials of his name on the side, ti a list of products will appear kindred at the research, your then select by each product the quantity and the source and destination state.',
      'confirm': 'Confirm',
      'readyForUnloading': 'Ready for unloading',
      'year': 'Year',
      'boxes': 'Boxes',
      'bottles': 'Bottles',
      'priceForPrivate': 'Price for private',
      'pricePerReseller': 'Price per reseller',
      'singleBarcode': 'Single barcode',
      'packageBarcode': 'Package barcode',
      'addYear': 'Add year',
      'search': 'Search',
      'searchAll': 'Search all',
      'or': 'Or',
      'available': 'Available',
      'searchStuff': 'Search stuff',
      'thresholdForWarning': 'Threshold for warning',
      'searchStuffByName': "Name of the stuff to search for",
      'addStuff': 'Add stuff',
      'unitOfMeasure': 'Unit of measure',
      'infoAddStuffButton': 'In this panel you can enter the material present in the warehouse.',
      'stuff': 'Stuff',
      'type': 'Type',
      'unload': 'Unload',
      'load': 'Load',
      'infoAddMovementStuffButton': 'In this panel you can download the material after using it.',
      'doYouWantToRemove': 'Do you want to remove',
      'fieldCannotEmpty': 'Field can\'t be empty',
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
      'showUsers' : 'Mostra utenti',
      'hideUsers' : 'Nascondi utenti',
      'addUser': 'Aggiungi utente',
      "edit": 'Modifica',
      "delete": 'Elimina',
      'code' : 'Codice',
      'salaryPerDay' : 'Salario giornaliero',
      'cancel' : 'Annulla',
      'capability': 'Capacità',
      'addProduct': 'Aggiungi prodotto',
      'addStuffs': 'Aggiungi materiale',
      'products': 'Prodotti',
      'stuffs': 'Materiali',
      'addCapability': 'Aggiungi capacità',
      'editUser': 'Modifica utente',
      'deleteUser': 'Elimina utente',
      'showCalendar': 'Mostra calendario',
      'daysThisMonth': 'Giornate questo mese',
      'daysPreviousMonth': 'Giornate mese precedente',
      'addDay': 'Aggiungi giornata',
      'day': 'Giorno',
      'summary': 'Riepilogo',
      'month': 'Mese',
      'thisMonth': 'Questo mese',
      'previousMonth': 'Mese precedente',
      'days': 'Giornate', 
      'salary': 'Salario',
      'date': 'Data', 
      'noResult': 'Nessun risultato', 
      'product': 'Prodotti',
      'movements': 'Movimenti',
      'state': 'Stato',
      'receipts': 'Ricevute',
      'user': 'Utente', 
      'termsOfPayment': 'Metodo di pagamento',
      'price': 'Prezzo',
      'discount': 'Sconto',
      'amount': 'Totale',
      'name': 'Nome',
      'favourite': 'Preferito',
      'addState': 'Aggiungi stato',
      'enterTheNameOfTheState': 'Inserisci il nome dello stato',
      'infoStateButton': 'In questo pannello puoi creare, modificare e rimuovere gli stati dei prodotti, il preferito verrà visualizzato quando fai la ricerca dei prodotti, se marchi uno stato lo marchi come "scaricabile" (dunque la terza iconcina) chi ha il solo permesso di visualizzazione e scarico prodotti potrà utilizzare i prodotti in tale stato solo per lo scarico.',
      'info': 'Informazioni',
      'quantity': 'Quantità',
      'from': 'Da',
      'to': 'A',
      'description': 'Descrizione',
      'addMovement': 'Aggiungi movimento',
      'enterReasonForUnloading': 'Inserisci motivo di scarico',
      'searchProduct': 'Cerca prodotto',
      'productName': 'Nome del prodotto',
      'searchByProductName': "Nome del prodotto da cercare",
      'infoMovementButton': 'In questo pannello puoi cambiare lo stato dei prodotti, inserisci la motivazione e poi cerca i prodotti da scaricare scrivendo le iniziali del suo nome qui di fianco, ti apparirà una lista dei prodotti affini alla ricerca, tua successivamente seleziona per ogni prodotto la quantità e lo stato sorgente e destinazione.',
      'confirm': 'Conferma',
      'readyForUnloading': 'Pronti per essere scaricati',
      'year': 'Anno',
      'boxes': 'Cartoni',
      'bottles': 'Bottiglie',
      'priceForPrivate': 'Prezzo per privato',
      'pricePerReseller': 'Prezzo per rivenditore',
      'singleBarcode': 'Codice a barre singolo',
      'packageBarcode': 'Codice a barre confezione',
      'addYear': 'Aggiungi annata',
      'search': 'Cerca',
      'searchAll': 'Cerca tutti',
      'or': 'Oppure',
      'available': 'Disponibile',
      'searchStuff': 'Cerca materiale',
      'thresholdForWarning': 'Soglia per avviso',
      'searchStuffByName': "Nome del materiale da cercare",
      'addStuff': 'Aggiungi materiale',
      'unitOfMeasure': 'Unità di misura',
      'infoAddStuffButton': 'In questo pannello puoi inserire il materiale presente nel magazzino.',
      'stuff': 'Materiale',
      'type': 'Tipo',
      'unload': 'Scarica',
      'load': 'Carica',
      'infoAddMovementStuffButton': 'In questo pannello puoi scaricare il materiale dopo averlo utilizzato.',
      'doYouWantToRemove': 'Vuoi eliminare',
      'fieldCannotEmpty': 'Il campo non può essere vuoto',
    },
    // Aggiungi altre lingue qui...
  };
}



