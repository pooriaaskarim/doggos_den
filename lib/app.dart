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

  static void rebuildApp(final BuildContext context) {
    context.findAncestorStateOfType<_AppState>()?.rebuildApp();
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppBloc>(context).add(InitializeApp());
  }

  @override
  void dispose() {
    BlocProvider.of<AppBloc>(context).close();
    super.dispose();
  }

  void rebuildApp() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      AppUtils.rebuildDescendantChildren(context);
    });
  }

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
