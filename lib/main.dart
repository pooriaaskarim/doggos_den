import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'application/app_bloc/app_bloc.dart';

void main() {
  runApp(
    BlocProvider(create: (final context) => AppBloc(), child: const App()),
  );
}
