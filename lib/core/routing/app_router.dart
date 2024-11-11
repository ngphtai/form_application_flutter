import 'package:dsoft_form_application/domain/models/meta_data_model.dart';
import 'package:dsoft_form_application/presentation/detail_screen/detail_page_screen.dart';

import 'package:dsoft_form_application/presentation/home_screen/home_page_screen.dart';
import 'package:dsoft_form_application/presentation/splash_screen/splash_screen.dart';
import 'package:dsoft_form_application/presentation/success_screen/success_page_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/form_screen/form_page_screen.dart';
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
                name: "detail",
                path: "${Routers.detailPage}/:postId",
                builder: (context, state) {
                  String postId = state.pathParameters['postId']!;
                  return DetailPageScreen(postId: postId);
                },
                routes: [
                  GoRoute(
                      path: Routers.formPage,
                      builder: (context, state) {
                        String postId = state.pathParameters['postId']!;
                        return FormPageScreen(postId: postId);
                      },
                      routes: [
                        GoRoute(
                          name: "SuccessPage",
                          path: Routers.successPage,
                          builder: (context, state) {
                            // final metaDataModel = state.extra as MetaDataModel;

                            String title =
                                state.uri.queryParameters['title'] ?? '';
                            String title2 =
                                state.uri.queryParameters['title2'] ?? '';
                            String content =
                                state.uri.queryParameters['content'] ?? '';

                            return SuccessPageScreen(
                                title: title, title2: title2, content: content);
                          },
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
