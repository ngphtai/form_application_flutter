import 'package:dsoft_form_application/core/routing/navigationbar.dart';
import 'package:dsoft_form_application/presentation/history_screen/history_page_screen.dart';

import '../../presentation/form_screen/form_page_screen.dart';

import '../../presentation/success_screen/success_page_screen.dart';
import '../../presentation/detail_screen/detail_page_screen.dart';
import '../../presentation/home_screen/home_page_screen.dart';

import '../../presentation/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'route_path.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorHistoryKey = GlobalKey<NavigatorState>();

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routers.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) =>
            ScaffoldWithNavigationCustoms(navigatorShell: navShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
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
                              // Lấy queryParameters từ URI
                              String title =
                                  state.uri.queryParameters['title'] ?? '';
                              String title2 =
                                  state.uri.queryParameters['title2'] ?? '';
                              String content =
                                  state.uri.queryParameters['content'] ?? '';

                              return NoTransitionPage(
                                  key: state.pageKey,
                                  restorationId: state.pageKey.value,
                                  child: SuccessPageScreen(
                                      title: title,
                                      title2: title2,
                                      content: content));
                            },
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHistoryKey,
            initialLocation: Routers.historyPage,
            routes: [
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
                        name: Routers.reviewFormPage,
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
                            name: Routers.reviewSuccessPage,
                            path: Routers.successPage,
                            pageBuilder: (context, state) {
                              // Lấy queryParameters từ URI
                              String title =
                                  state.uri.queryParameters['title'] ?? '';
                              String title2 =
                                  state.uri.queryParameters['title2'] ?? '';
                              String content =
                                  state.uri.queryParameters['content'] ?? '';

                              return NoTransitionPage(
                                  key: state.pageKey,
                                  restorationId: state.pageKey.value,
                                  child: SuccessPageScreen(
                                      title: title,
                                      title2: title2,
                                      content: content));
                            },
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );
}
// }
// class AppRouter {
//   late final router = GoRouter(
//     debugLogDiagnostics: true,
//     routes: [
//       GoRoute(
//         path: Routers.splash,
//         builder: (_, __) => const SplashScreen(),
//       ),
//       StatefulShellRoute.indexedStack(
//         builder: (context, state, navShell) => MainScreen(child: navShell),
//         branches: [
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 name: Routers.homePage,
//                 path: Routers.homePage,
//                 pageBuilder: (context, state) {
//                   return NoTransitionPage(
//                     key: state.pageKey,
//                     child: const HomePageScreen(),
//                     restorationId: state.pageKey.value,
//                   );
//                 },
//                 routes: [
//                   GoRoute(
//                     name: Routers.detailPage,
//                     path: "${Routers.detailPage}/:postId",
//                     pageBuilder: (context, state) {
//                       String postId = state.pathParameters['postId']!;
//                       return NoTransitionPage(
//                           key: state.pageKey,
//                           restorationId: state.pageKey.value,
//                           child: DetailPageScreen(postId: postId));
//                     },
//                     routes: [
//                       GoRoute(
//                         name: Routers.formPage,
//                         path: Routers.formPage,
//                         pageBuilder: (context, state) {
//                           String postId = state.pathParameters['postId']!;
//                           return NoTransitionPage(
//                               key: state.pageKey,
//                               restorationId: state.pageKey.value,
//                               child: FormPageScreen(postId: postId));
//                         },
//                         routes: [
//                           GoRoute(
//                             name: Routers.successPage,
//                             path: Routers.successPage,
//                             pageBuilder: (context, state) {
//                               // Lấy queryParameters từ URI
//                               String title =
//                                   state.uri.queryParameters['title'] ?? '';
//                               String title2 =
//                                   state.uri.queryParameters['title2'] ?? '';
//                               String content =
//                                   state.uri.queryParameters['content'] ?? '';

//                               return NoTransitionPage(
//                                   key: state.pageKey,
//                                   restorationId: state.pageKey.value,
//                                   child: SuccessPageScreen(
//                                       title: title,
//                                       title2: title2,
//                                       content: content));
//                             },
//                           )
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 name: Routers.historyPage,
//                 path: Routers.historyPage,
//                 pageBuilder: (context, state) {
//                   return NoTransitionPage(
//                     key: state.pageKey,
//                     child: const HistoryPageScreen(),
//                     restorationId: state.pageKey.value,
//                   );
//                 },
//               )
//             ],
//           ),
//         ],
//       ),
//     ],
//     redirect: (context, state) {
//       return null;
//     },
//   );
// }
