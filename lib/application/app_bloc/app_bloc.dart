import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/breed.dart';
import '../../infrastructure/repositories/local/repository.local.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required final LocalRepository localRepository})
      : _localRepository = localRepository,
        super(const AppInitializingState()) {
    on<InitializeApp>(onAppInitialization);
    on<ToggleThemeMode>(onToggleThemeMode);
  }
  final LocalRepository _localRepository;

  Future<FutureOr<void>> onAppInitialization(
    final InitializeApp event,
    final Emitter<AppState> emit,
  ) async {
    final ThemeMode themeMode = await _localRepository.getThemeMode();
    emit(AppInitializingState(themeMode: themeMode, breeds: state.breeds));
  }

  Future<FutureOr<void>> onToggleThemeMode(
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
