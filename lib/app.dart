import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/app_bloc/app_bloc.dart';
import 'infrastructure/config/routes/app.route_names.dart';
import 'infrastructure/config/routes/app.routes.dart';
import 'infrastructure/config/theme/app.theme.dart';
import 'infrastructure/utils/app.utils.dart';
import 'presentation/home/screen.home.dart';

class App extends StatefulWidget {
  const App({super.key});

  static final GlobalKey<NavigatorState> _globalNavigatorKey =
      GlobalKey<NavigatorState>();
  static NavigatorState? navigator = _globalNavigatorKey.currentState;

  static late ThemeData theme;

  static void rebuildApp(final BuildContext context) {
    context.findAncestorStateOfType<_AppState>()?.rebuildApp();
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData get _fallbackTheme =>
      (MediaQuery.of(context).platformBrightness == Brightness.light)
          ? AppTheme.lightTheme
          : AppTheme.darkTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    App.theme = _fallbackTheme;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void rebuildApp() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      AppUtils.rebuildDescendantChildren(context);
    });
  }

  @override
  Widget build(final BuildContext context) => BlocListener<AppBloc, AppState>(
        listenWhen: (final previous, final current) =>
            previous.runtimeType != current.runtimeType,
        listener: (final context, final appState) async {
          // if (appState is AppAuthenticatedState) {
          //   _settingsBloc.add(
          //     SettingsAuthenticateEvent(
          //       configurations: appState.user!.configurations,
          //     ),
          //   );
          //   _packageBloc
          //       .add(AuthenticatePackageEvent(package: appState.user!.package));
          // } else if (appState is AppUnAuthenticatedState) {
          //   _packageBloc.add(const UnAuthenticatePackageEvent());
          //   _settingsBloc.add(
          //     SettingsUnAuthenticateEvent(
          //       context: context,
          //     ),
          //   );
          // }
        },
        child: MaterialApp(
          title: "Doggo's Den",
          theme: App.theme,
          navigatorKey: App._globalNavigatorKey,
          // theme: ChartixTheme.light.data,
          // darkTheme: userDarkTheme(state)?.data,
          // themeMode: (userDarkTheme(state) != null)
          //     ? ThemeMode.dark
          //     : ThemeMode.light,
          // navigatorKey: Chartix._globalNavigatorKey,
          home: const Home(),
          onGenerateRoute: (final routeSettings) => AppRoutes.getRoute(
            routeSettings.name ?? AppRouteNames.notFound,
          ),
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: false,
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          debugShowCheckedModeBanner: false,
        ),
      );
}
