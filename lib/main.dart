import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'application/app_bloc/app_bloc.dart';
import 'application/doggo_cubit/doggo_cubit.dart';
import 'infrastructure/repositories/local/repository.local.dart';
import 'infrastructure/repositories/network/doggo.repository.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (final context) => DoggoRepository(),
        ),
        RepositoryProvider(
          create: (final context) => LocalRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (final context) => AppBloc(
              localRepository: RepositoryProvider.of<LocalRepository>(context),
              doggoRepository: RepositoryProvider.of<DoggoRepository>(context),
            )..add(InitializeApp()),
          ),
          BlocProvider(
            create: (final context) => DoggoCubit(
              doggoRepository: RepositoryProvider.of<DoggoRepository>(context),
            ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
