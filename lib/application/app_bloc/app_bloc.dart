import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/models/breed.dart';
import '../../infrastructure/repositories/local/repository.local.dart';
import '../../infrastructure/repositories/network/doggo.repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required final LocalRepository localRepository,
    required final DoggoRepository doggoRepository,
  })  : _localRepository = localRepository,
        _doggoRepository = doggoRepository,
        super(const InitializingState()) {
    on<InitializeApp>(onAppInitialization);
    on<FetchBreeds>(onFetchDoggos);
    on<ToggleThemeMode>(onToggleThemeMode);
  }

  final LocalRepository _localRepository;
  final DoggoRepository _doggoRepository;

  FutureOr<void> onAppInitialization(
    final InitializeApp event,
    final Emitter<AppState> emit,
  ) async {
    final ThemeMode themeMode = await _localRepository.getThemeMode();
    add(FetchBreeds());
    emit(FetchingBreedsState(themeMode: themeMode, breeds: state.breeds));
  }

  FutureOr<void> onFetchDoggos(
    final FetchBreeds event,
    final Emitter<AppState> emit,
  ) async {
    final response = await _doggoRepository.getAllBreeds();

    final breedsList = <Breed>[];
    response.fold((final l) {
      emit(ErrorState(breeds: state.breeds, themeMode: state.themeMode));
      throw l;
    }, (final r) {
      for (final entry in (r.data['message'] as Map<String, dynamic>).entries) {
        breedsList.add(
          Breed(
            name: entry.key,
            subBreeds: (entry.value as List<dynamic>)
                .map((final e) => SubBreed(name: e))
                .toList(),
          ),
        );
      }
    });

    emit(InitializedState(breeds: breedsList, themeMode: state.themeMode));
  }

  FutureOr<void> onToggleThemeMode(
    final ToggleThemeMode event,
    final Emitter<AppState> emit,
  ) async {
    final ThemeMode themeMode = ThemeMode.values
            .elementAtOrNull(ThemeMode.values.indexOf(state.themeMode) + 1) ??
        ThemeMode.values.first;

    emit(state.copyWith(themeMode: themeMode));
    await _localRepository.persistThemeMode(state.themeMode);
  }
}
