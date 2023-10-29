import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/app_bloc/app_bloc.dart';
import 'infrastructure/config/routes/app.route_names.dart';
import 'infrastructure/config/routes/app.routes.dart';
import 'infrastructure/config/theme/app.theme.dart';
import 'presentation/splash/screen.splash.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final GlobalKey<NavigatorState> _globalNavigatorKey =
      GlobalKey<NavigatorState>();
  static NavigatorState? navigator = _globalNavigatorKey.currentState;

  @override
  Widget build(final BuildContext context) => BlocBuilder<AppBloc, AppState>(
        buildWhen: (final previous, final current) =>
            previous.themeMode != current.themeMode,
        builder: (final context, final state) => MaterialApp(
          title: "Doggo's Den",
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: state.themeMode,
          navigatorKey: App._globalNavigatorKey,
          home: const SplashScreen(),
          onGenerateRoute: (final routeSettings) => AppRoutes.getRoute(
            routeSettings.name ?? AppRouteNames.notFound,
          ),
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: true,
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          debugShowCheckedModeBanner: false,
        ),
      );
}
