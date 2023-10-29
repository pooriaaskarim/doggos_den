part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState({
    required this.breeds,
    required this.themeMode,
  });

  final List<Breed> breeds;
  final ThemeMode themeMode;

  AppState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  });

  @override
  List<Object> get props => [
        themeMode,
      ];
}

/// AppState: initial run
/// empty [Breed]s list and [ThemeMode].system
class InitializingState extends AppState {
  const InitializingState({
    super.breeds = const [],
    super.themeMode = ThemeMode.system,
  });

  @override
  InitializingState copyWith(
          {final List<Breed>? breeds, final ThemeMode? themeMode}) =>
      InitializingState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

/// AppState: Gathering [Breed]s list
class FetchingBreedsState extends AppState {
  const FetchingBreedsState({
    super.breeds = const [],
    super.themeMode = ThemeMode.system,
  });

  @override
  FetchingBreedsState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  }) =>
      FetchingBreedsState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

/// AppState: App is Loaded with proper [ThemeMode] and [Breed]s list
class InitializedState extends AppState {
  const InitializedState({
    required super.breeds,
    required super.themeMode,
  });

  @override
  InitializedState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  }) =>
      InitializedState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

/// AppState: Some Error occurred (during fetching [Breed]s list)
class ErrorState extends AppState {
  const ErrorState({
    required super.breeds,
    required super.themeMode,
  });
  @override
  ErrorState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  }) =>
      ErrorState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}
