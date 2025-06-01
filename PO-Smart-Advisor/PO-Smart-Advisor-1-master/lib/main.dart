import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:po_smart_advisor/provider/app_provider.dart';
import 'package:po_smart_advisor/screens/bottom_navbar.dart';
import 'package:po_smart_advisor/screens/forms.dart';
import 'package:po_smart_advisor/screens/home_screen.dart';
import 'package:po_smart_advisor/screens/interest_calculator.dart';
import 'package:po_smart_advisor/screens/schemes.dart';
import 'package:po_smart_advisor/screens/splash_screen.dart';
import 'package:po_smart_advisor/screens/username_screen.dart';
import 'package:po_smart_advisor/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await Hive.openBox('userBox');

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider()..loadUsernameFromHive(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return ToastificationWrapper(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (_) => const SplashScreen(),
              '/username': (context) => const UsernameScreen(),
              '/bottombar': (context) => const BottomNavaBarScreen(),
              '/home': (context) => HomeScreen(
                    tabPage: (index) => (),
                  ),
              '/schemes': (context) => const SchemesScreen(),
              '/calculator': (context) => const SmartAdvisorScreen(),
              'forms': (context) => const FormsScreen(),
            },
          ),
        );
      },
    );
  }
}
