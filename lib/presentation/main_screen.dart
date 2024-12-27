import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/constant/data/main_screen_data.dart';
import '../common/constant/data/nav_bottom_data.dart';
import '../core/locators/locators.dart';
import '../core/routing/app_router.dart';
import '../core/routing/route_path.dart';
import '../core/styles/app_text_style.dart';

/// {@template main_screen}
/// [MainScreen] returns a widget that has mutable state [_MainScreenState].
/// The place contains the main pages of the app
/// that the user uses when successfully logged in.
/// {@endtemplate}
class MainScreen extends StatefulWidget {
  /// {@macro main_screen}
  const MainScreen({super.key, required this.child});

  /// View need display with navigation bar bottom
  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final AppRouter appRouter;
  late final NavBottomData navBottomData;

  @override
  void initState() {
    navBottomData = NavBottomData();
    appRouter = diAppRouter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        top: false,
        bottom: Platform.isAndroid ? true : false,
        child: widget.child,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.redAccent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          elevation: 0,
          unselectedLabelStyle: AppTextStyle.regular11,
          selectedLabelStyle: AppTextStyle.regular11,
          currentIndex: _calculateSelectedIndex(context).indexTab,
          onTap: _onTap,
          items: navBottomData
              .getNavBottomItemsData(context: context)
              .map((e) => BottomNavigationBarItem(
                    icon: e.icon,
                    activeIcon: e.activeIcon,
                    label: e.label,
                  ))
              .toList(),
        ),
      ),
    );
  }

  BottomNavMainScreen _calculateSelectedIndex(BuildContext context) {
    final route = appRouter.router;
    final location = route.routeInformationProvider.value.uri.path;
    if (location.startsWith(Routers.homePage)) {
      return BottomNavMainScreen.home;
    }
    if (location.startsWith(Routers.historyPage)) {
      return BottomNavMainScreen.second;
    }
    // if (location.startsWith(Routers.thirdPage)) {
    //   return BottomNavMainScreen.third;
    // }
    // if (location.startsWith(Routers.profilePage)) {
    //   return BottomNavMainScreen.profile;
    // }
    return BottomNavMainScreen.home;
  }

  void _onTap(int? value) {
    final tabType = _getTabType(value);
    // remove condition if support event page
    switch (tabType) {
      case BottomNavMainScreen.home:
        context.go(Routers.homePage);
        break;
      case BottomNavMainScreen.second:
        context.go(Routers.historyPage);
        break;
      // case BottomNavMainScreen.third:
      //   context.go(Routers.thirdPage);
      //   break;
      // case BottomNavMainScreen.profile:
      //   context.go(Routers.profilePage);
      // break;
      default:
        context.go(Routers.homePage);
        break;
    }
  }

  BottomNavMainScreen _getTabType(int? value) =>
      BottomNavMainScreen.values.firstWhere((e) => e.indexTab == value);
}
