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

class FetchingDoggosState extends AppState {
  const FetchingDoggosState({
    super.breeds = const [],
    super.themeMode = ThemeMode.system,
  });

  @override
  FetchingDoggosState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  }) =>
      FetchingDoggosState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

abstract class InitializedState extends AppState {
  const InitializedState({
    required super.breeds,
    required super.themeMode,
  });
}

class LoadedState extends InitializedState {
  const LoadedState({
    required super.breeds,
    required super.themeMode,
  });
  @override
  LoadedState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  }) =>
      LoadedState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

class LoadingState extends InitializedState {
  const LoadingState({
    required super.breeds,
    required super.themeMode,
  });

  @override
  LoadingState copyWith({
    final List<Breed>? breeds,
    final ThemeMode? themeMode,
  }) =>
      LoadingState(
        breeds: breeds ?? this.breeds,
        themeMode: themeMode ?? this.themeMode,
      );
}

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
