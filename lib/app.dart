import '/presentation/splash_screen/components/splash_place_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'common/constant/constants.dart';
import 'core/locators/locators.dart';
import 'core/styles/app_design_size.dart';
import 'core/styles/app_theme.dart';
import 'shared/states/theme/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiRepositoryProvider(
    //   providers: [
    //     RepositoryProvider(create: (_) => diHomeRepository),
    //   ],
    // child:
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => diSplashBloc),
        // BlocProvider(create: (_) => diHomePageBloc),
        // BlocProvider(create: (_) => diAppStatusCubit),
        BlocProvider(create: (_) => diThemeCubit..initialize()),
      ],
      child: FutureBuilder(
        future: di.allReady(),
        builder: (context, s) {
          if (s.hasData) {
            return BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, state) {
                _initConfigureScreenUtils(context);
                return _builderAppContent(
                  isMainContent: true,
                  state: state,
                );
              },
            );
          }
          return _builderAppContent(isMainContent: false);
        },
      ),
    );
    // );
  }

  /// Build App content for default splash and main screen
  Widget _builderAppContent({
    required bool isMainContent,
    ThemeData? state,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => primaryFocus?.unfocus(),
      child: isMainContent
          ? MaterialApp.router(
              title: AppConstants.appName,
              routerDelegate: diAppRouter.router.routerDelegate,
              routeInformationParser: diAppRouter.router.routeInformationParser,
              routeInformationProvider:
                  diAppRouter.router.routeInformationProvider,
              debugShowCheckedModeBanner: false,
              // supportedLocales: SLang.delegate.supportedLocales,
              localizationsDelegates: const [
                // SLang.delegate,
                // GlobalMaterialLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate,
                // GlobalCupertinoLocalizations.delegate,
              ],
              // routerConfig: diAppRouter.router,
              theme: ThemeData.light().copyWith(
                textTheme: ThemeData.light().textTheme.apply(
                      fontFamily: 'Poppins',
                    ),
              ),
              builder: FlutterSmartDialog.init(
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.noScaling),
                  child: child!,
                ),
              ),
            )
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (c, w) => const SplashPlaceHolder(),
              theme: AppTheme.lightTheme,
            ),
    );
  }

  void _initConfigureScreenUtils(BuildContext context) {
    ScreenUtil.init(context, minTextAdapt: true);
    ScreenUtil.configure(designSize: AppDesignSize().getScreenSize());
  }
}
