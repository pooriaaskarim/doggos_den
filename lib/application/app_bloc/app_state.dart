part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState({required this.breeds, required this.themeMode});

  final List<Breed> breeds;
  final ThemeMode themeMode;

  AppState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  });

  @override
  List<Object> get props => [
        breeds,
        themeMode,
      ];
}

class AppInitializingState extends AppState {
  const AppInitializingState({
    super.breeds = const [],
    super.themeMode = ThemeMode.system,
  });

  @override
  AppInitializingState copyWith(
          {final List<Breed>? breeds, final ThemeMode? themeMode}) =>
      AppInitializingState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

abstract class AppInitializedState extends AppState {
  const AppInitializedState({
    required super.breeds,
    required super.themeMode,
  });
}

class AppLoadedState extends AppInitializedState {
  const AppLoadedState({
    required super.breeds,
    required super.themeMode,
  });
  @override
  AppLoadedState copyWith(
          {final List<Breed>? breeds, final ThemeMode? themeMode}) =>
      AppLoadedState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

class AppLoadingState extends AppInitializedState {
  const AppLoadingState({
    required super.breeds,
    required super.themeMode,
  });
  @override
  AppLoadingState copyWith(
          {final List<Breed>? breeds, final ThemeMode? themeMode}) =>
      AppLoadingState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

class AppErrorState extends AppInitializedState {
  const AppErrorState({
    required super.breeds,
    required super.themeMode,
  });
  @override
  AppErrorState copyWith(
          {final List<Breed>? breeds, final ThemeMode? themeMode}) =>
      AppErrorState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}
