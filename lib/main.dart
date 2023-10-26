import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'application/app_bloc/app_bloc.dart';
import 'infrastructure/repositories/local/repository.local.dart';

void main() {
  runApp(
    BlocProvider(
      create: (final context) => AppBloc(
        localRepository: LocalRepository.instance(),
      ),
      child: const App(),
    ),
  );
}
