import 'package:po/app/app_imports/app_imports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.addAccountScreen,
        builder: (context, state) => const AddAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationScreen,
        builder: (context, state) => const NotificationScreen(),
      ),
    ],
  );
}

class AppRoutes {
  static String homeScreen = '/';
  static String addAccountScreen = '/addAccount';
  static String notificationScreen = '/notification';
}
