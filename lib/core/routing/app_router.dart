import 'package:dsoft_form_application/presentation/fail_screen/fail_page_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '/presentation/history_screen/history_page_screen.dart';
import '../../initializer.dart';
import '../../presentation/form_screen/form_page_screen.dart';
import '../../presentation/success_screen/success_page_screen.dart';
import '../../presentation/detail_screen/detail_page_screen.dart';
import '../../presentation/home_screen/home_page_screen.dart';
import '../../presentation/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'route_path.dart';

class AppRouter {
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
  late final router = GoRouter(
    debugLogDiagnostics: true,
    observers: [observer], // Observer Firebase Analytics
    navigatorKey: Initializer.instance.navigatorKey,
    routes: [
      GoRoute(
        path: Routers.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        name: Routers.homePage,
        path: Routers.homePage,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: const HomePageScreen(),
            restorationId: state.pageKey.value,
          );
        },
        routes: [
          GoRoute(
            name: Routers.detailPage,
            path: "${Routers.detailPage}/:postId",
            pageBuilder: (context, state) {
              String postId = state.pathParameters['postId']!;
              return NoTransitionPage(
                  key: state.pageKey,
                  restorationId: state.pageKey.value,
                  child: DetailPageScreen(postId: postId));
            },
            routes: [
              GoRoute(
                name: Routers.formPage,
                path: Routers.formPage,
                pageBuilder: (context, state) {
                  String postId = state.pathParameters['postId']!;
                  return NoTransitionPage(
                      key: state.pageKey,
                      restorationId: state.pageKey.value,
                      child: ReviewFormPageScreen(postId: postId));
                },
                routes: [
                  GoRoute(
                    name: Routers.successPage,
                    path: Routers.successPage,
                    pageBuilder: (context, state) {
                      String title = state.uri.queryParameters['title'] ?? '';
                      return NoTransitionPage(
                        key: state.pageKey,
                        restorationId: state.pageKey.value,
                        child: SuccessPageScreen(title: title),
                      );
                    },
                  ),
                  GoRoute(
                    name: Routers.failPage,
                    path: Routers.failPage,
                    pageBuilder: (context, state) {
                      String title = state.uri.queryParameters['title'] ?? '';
                      return NoTransitionPage(
                          key: state.pageKey,
                          restorationId: state.pageKey.value,
                          child: FailPageScreen(
                            title: title,
                          ));
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
      GoRoute(
        name: Routers.historyPage,
        path: Routers.historyPage,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: const HistoryPageScreen(),
            restorationId: state.pageKey.value,
          );
        },
        routes: [
          GoRoute(
            name: Routers.reviewDetailPage,
            path: "${Routers.reviewDetailPage}/:postId",
            pageBuilder: (context, state) {
              String postId = state.pathParameters['postId']!;
              return NoTransitionPage(
                  key: state.pageKey,
                  restorationId: state.pageKey.value,
                  child: DetailPageScreen(postId: postId));
            },
            routes: [
              GoRoute(
                name: Routers.reviewFormPage,
                path: Routers.formPage,
                pageBuilder: (context, state) {
                  String postId = state.pathParameters['postId']!;
                  return NoTransitionPage(
                      key: state.pageKey,
                      restorationId: state.pageKey.value,
                      child: ReviewFormPageScreen(postId: postId));
                },
              )
            ],
          )
        ],
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );
}
