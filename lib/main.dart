import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'application/app_bloc/app_bloc.dart';
import 'infrastructure/repositories/local/repository.local.dart';
import 'infrastructure/repositories/network/doggo.repository.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (final context) => DoggoRepository(),
      child: BlocProvider(
        create: (final context) => AppBloc(
          localRepository: LocalRepository.instance(),
          doggoRepository: RepositoryProvider.of<DoggoRepository>(context),
        ),
        child: const App(),
      ),
    ),
  );
}
