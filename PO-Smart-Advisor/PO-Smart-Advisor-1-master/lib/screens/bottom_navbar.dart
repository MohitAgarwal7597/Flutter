import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:po_smart_advisor/screens/forms.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:po_smart_advisor/screens/home_screen.dart';
import 'package:po_smart_advisor/screens/interest_calculator.dart';
import 'package:po_smart_advisor/screens/schemes.dart';
import 'package:po_smart_advisor/theme/app_color.dart';

class BottomNavaBarScreen extends StatefulWidget {
  const BottomNavaBarScreen({super.key});

  @override
  State<BottomNavaBarScreen> createState() => _BottomNavaBarScreenState();
}

class _BottomNavaBarScreenState extends State<BottomNavaBarScreen> {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        tabPage: (int index) {
          _controller.jumpToTab(index);
        },
      ),
      const SchemesScreen(),
      const SmartAdvisorScreen(),
      const FormsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: "Home",
        activeColorSecondary: AppColor.scaffoldBackgroundColor,
        activeColorPrimary: AppColor.containerLightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.list_alt_outlined),
        title: "Schemes",
        activeColorSecondary: AppColor.scaffoldBackgroundColor,
        activeColorPrimary: AppColor.containerLightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        activeColorSecondary: AppColor.scaffoldBackgroundColor,
        activeColorPrimary: AppColor.containerLightBlue,
        icon: const Icon(Icons.calculate_outlined),
        inactiveColorPrimary: Colors.grey,
        title: "Interest\nCalculator",
        textStyle: const TextStyle(fontSize: 12),
      ),
      PersistentBottomNavBarItem(
        activeColorSecondary: AppColor.scaffoldBackgroundColor,
        activeColorPrimary: AppColor.containerLightBlue,
        icon: const Icon(Icons.picture_as_pdf),
        inactiveColorPrimary: Colors.grey,
        title: "Forms",
        textStyle: const TextStyle(fontSize: 12),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          false, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: AppColor.containerDarkBlue,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property
    );
  }
}
