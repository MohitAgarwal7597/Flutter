import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kColorTheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 255, 76),
);
var kDarKTheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
  //   fn,
  // ) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          // filled: true,

          // counterStyle: TextStyle(color: Colors.amber),
          // fillColor: Colors.grey,
        ),
        colorScheme: kDarKTheme,
        cardTheme: CardTheme().copyWith(
          color: kDarKTheme.primary,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        ),
        appBarTheme: AppBarTheme().copyWith(
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: kDarKTheme.primaryContainer,
          foregroundColor: kDarKTheme.onPrimaryContainer,
        ),
        //  dropdownButtonTheme: DropdownButtonThemeData(
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        // ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarKTheme.primaryContainer,
            foregroundColor: kColorTheme.onPrimary,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,

            color: kColorTheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        cardTheme: CardTheme().copyWith(
          color: kColorTheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        ),
        // scaffoldBackgroundColor: const Color.fromARGB(151, 1, 42, 62),
        appBarTheme: AppBarTheme().copyWith(
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: kColorTheme.onPrimaryContainer,
          foregroundColor: kColorTheme.onPrimary,
        ),
        colorScheme: kColorTheme,
        //To Change Elevated button color theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorTheme.primaryContainer,
            // foregroundColor: kColorTheme.secondary,
          ),
        ),
        //To change text button theme color
        // textButtonTheme: TextButtonThemeData(
        //   style: TextButton.styleFrom(
        //     foregroundColor: const Color.fromARGB(255, 67, 19, 0),
        //     backgroundColor: Colors.white,
        //   ),
        // ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: kColorTheme.onPrimaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: Expenses(),
    ),
  );
  // });
}
