import 'package:flutter/material.dart';

import 'app.route_names.dart';

class AppRoutes {
  AppRoutes._();

  static MaterialPageRoute getRoute(final String routeName) =>
      routes.containsKey(routeName)
          ? routes[routeName]!()
          : routes[AppRouteNames.notFound]!();

  static Map<String, MaterialPageRoute Function()> routes = {};
}
