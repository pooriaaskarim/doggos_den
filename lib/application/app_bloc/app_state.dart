part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitialState extends AppState {
  @override
  List<Object> get props => [];
}
