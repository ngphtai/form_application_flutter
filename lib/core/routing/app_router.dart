import 'package:dsoft_form_application/presentation/detail_screen/detail_page_screen.dart';

import 'package:dsoft_form_application/presentation/form_screen/form_page_screen2.dart';
import 'package:dsoft_form_application/presentation/home_screen/home_page_screen.dart';
import 'package:dsoft_form_application/presentation/splash_screen/splash_screen.dart';
import 'package:dsoft_form_application/presentation/success_screen/success_page_screen.dart';
import 'package:go_router/go_router.dart';

import 'route_path.dart';

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routers.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
          path: Routers.homePage,
          builder: (context, state) => const HomePageScreen(),
          routes: [
            GoRoute(
                path: Routers.detailPage,
                builder: (context, state) => const DetailPageScreen(),
                routes: [
                  GoRoute(
                      path: Routers.formPage,
                      builder: (context, state) => FormPageScreen2(),
                      routes: [
                        GoRoute(
                          path: Routers.successPage,
                          builder: (context, state) =>
                              const SuccessPageScreen(),
                        )
                      ])
                ])
          ])
    ],
    redirect: (c, state) {
      return null;
    },
  );
}
