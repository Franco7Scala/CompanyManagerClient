import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {

  static ThemeData myThemeData(bool isDarkTheme) => ThemeData(
    useMaterial3: true,
    
    primaryTextTheme: isDarkTheme ? Typography().white : Typography().black,
    
    textTheme: isDarkTheme ? Typography().white : Typography().black,
    
    primaryColor: isDarkTheme ? Colors.white : Colors.black,
    
    scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
    
    appBarTheme: _myAppBarTheme(isDarkTheme),
    
    navigationRailTheme: _myNavRailTheme(isDarkTheme),
    
    navigationBarTheme: _myNavBarTheme(isDarkTheme),
    
    cardTheme: _myCardTheme(isDarkTheme),
    
    //switchTheme: _mySwitchTheme(isDarkTheme),
    
    iconTheme: _myIconTheme(isDarkTheme),
    
    textButtonTheme: _myTextButtonTheme(isDarkTheme),

    inputDecorationTheme: _myTextFieldTheme(isDarkTheme),

    floatingActionButtonTheme: _myFABTheme(isDarkTheme),

    outlinedButtonTheme: _myOutlinedButtonTheme(isDarkTheme),

    dividerTheme: _myDividerTheme(isDarkTheme),
    
    dialogTheme: _myDialogTheme(isDarkTheme),

    chipTheme: _myChipTheme(isDarkTheme),
    
    datePickerTheme: _myDataPickerTheme(isDarkTheme),

    dataTableTheme: _myDataTableTheme(isDarkTheme),

    popupMenuTheme: _myPopupMenuTheme(isDarkTheme),

  );

  static AppBarTheme _myAppBarTheme(bool isDarkTheme) => AppBarTheme(
    backgroundColor: isDarkTheme ? Colors.black : Colors.white,
    titleTextStyle: TextStyle(
      color: isDarkTheme ? Colors.white : Colors.black,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: isDarkTheme ? Colors.white : Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: isDarkTheme ? Colors.white : Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle( 
        statusBarColor: isDarkTheme ? Colors.black : Colors.white,
        statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
     ),
  );

  static NavigationRailThemeData _myNavRailTheme(bool isDarkTheme) => NavigationRailThemeData(
    backgroundColor: isDarkTheme ? Colors.black : Colors.grey[50],
    indicatorColor: isDarkTheme ? Colors.white : Colors.black,
    selectedLabelTextStyle: TextStyle(
      color: isDarkTheme ? Colors.white : Colors.black,
      //fontSize: 12.0
      //letterSpacing: 1.0,
    ),
    unselectedLabelTextStyle: const TextStyle(
      color: Colors.grey,
      //fontSize: 10.0
    ),
    selectedIconTheme: IconThemeData(
      color: isDarkTheme ? Colors.black : Colors.white
    ),
    unselectedIconTheme: IconThemeData(
      color: isDarkTheme ? Colors.white : Colors.black
    ),
  );

  static NavigationBarThemeData _myNavBarTheme(bool isDarkTheme) => NavigationBarThemeData(
    backgroundColor: isDarkTheme ? Colors.black : Colors.white,
    indicatorColor: isDarkTheme ? Colors.white : Colors.black,
    iconTheme: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return IconThemeData(
          color: isDarkTheme ? Colors.black : Colors.white 
        );
      }
      return IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black
        );
    }),
    labelTextStyle: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TextStyle(
          fontSize: 12.0,
          color: isDarkTheme ? Colors.white : Colors.black,
          //letterSpacing: 1.0,
          overflow: TextOverflow.ellipsis,
        );
      }
      return const TextStyle(
        fontSize: 10.0,
        color: Colors.grey,
      );
    }),
  );

  /*
  static SwitchThemeData _mySwitchTheme(bool isDarkTheme) => SwitchThemeData(
    //thumbColor: MaterialStateProperty.all(Colors.black),
    trackColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected) ? Colors.grey[800] : null)
  );
  */

  static CardTheme _myCardTheme(bool isDarkTheme) => CardTheme(
    color: isDarkTheme ? Colors.grey[900] : Colors.grey[300],
  );

  static IconThemeData _myIconTheme(bool isDarkTheme) => IconThemeData(
    color: isDarkTheme ? Colors.white : Colors.black,
  );

  static TextButtonThemeData _myTextButtonTheme(bool isDarkTheme) => TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: isDarkTheme ? Colors.white : Colors.black,
      foregroundColor: isDarkTheme ? Colors.black : Colors.white,
      //padding: const EdgeInsets.all(Constants.buttonPadding),
    )
  );

  static InputDecorationTheme _myTextFieldTheme(bool isDarkTheme) => InputDecorationTheme(
    labelStyle: TextStyle(
      color: isDarkTheme ? Colors.grey : Colors.grey[800],
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: isDarkTheme ?  Colors.grey : Colors.black87,
      )
    ),
    suffixIconColor: isDarkTheme ?  Colors.grey : Colors.black87,
  );

  static FloatingActionButtonThemeData _myFABTheme(bool isDarkTheme) => FloatingActionButtonThemeData(
    backgroundColor: isDarkTheme ? Colors.white : Colors.black,
    foregroundColor: isDarkTheme ? Colors.black : Colors.white,
  );

  static OutlinedButtonThemeData _myOutlinedButtonTheme(bool isDarkTheme) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: isDarkTheme ? Colors.white : Colors.black,
    ),
  );

  static DividerThemeData _myDividerTheme(bool isDarkTheme) => DividerThemeData(
    color: isDarkTheme ? Colors.grey[900] : Colors.grey[200],
  );

  static DialogTheme _myDialogTheme(bool isDarkTheme) => DialogTheme(
    backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.white, 
    elevation: 10.0,
  );
  
  static ChipThemeData _myChipTheme(bool isDarkTheme) => ChipThemeData(
    //shape: RoundedRectangleBorder(
    //  borderRadius: BorderRadius.circular(25.0)
    //),
    backgroundColor: isDarkTheme ? Colors.black : Colors.white,
    labelStyle: TextStyle(
      color: isDarkTheme ? Colors. white : Colors.black,
    ),
    selectedColor: Colors.grey[400], //il colore del chip quando viene selezionato
    secondaryLabelStyle: const  TextStyle( //il colore del testo quando premo il chip 
      color: Colors.black,
    ),
    elevation: 5.0,
    iconTheme: IconThemeData(
      color: isDarkTheme ? Colors.white : Colors.black,
      size: 18.0
    )
  );

  static DatePickerThemeData _myDataPickerTheme(bool isDarkTheme) => DatePickerThemeData(
    backgroundColor: isDarkTheme ? Colors.black : Colors.white,
    headerForegroundColor: isDarkTheme ? Colors.white : Colors.black,
    dayForegroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return isDarkTheme ? Colors.white : Colors.black;
      },
    ),
    todayForegroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return isDarkTheme ? Colors.black : Colors.white;
      },
    ),
    todayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return isDarkTheme ? Colors.white : Colors.black;
      },
    ),
    weekdayStyle: TextStyle(
      color: isDarkTheme ? Colors.white : Colors.black,
    )

  );

  static DataTableThemeData _myDataTableTheme(bool isDarkTheme) => DataTableThemeData(
    headingTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: isDarkTheme ? Colors.white : Colors.black,
    )
  );

  static PopupMenuThemeData _myPopupMenuTheme(bool isDarkTheme) => PopupMenuThemeData(
    color: isDarkTheme ? Colors.grey[900] : Colors.white,
    labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
      (Set<MaterialState> states) {
        /*
        if (states.contains(MaterialState.pressed)) {
          return TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red, // Stile del testo quando premuto
          );
        }
        */
        return TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black, 
        );
      },
    ),
  );

}