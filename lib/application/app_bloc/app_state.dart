part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState({required this.breeds});

  final List<Breed> breeds;

  @override
  List<Object> get props => [breeds];
}

class AppInitializingState extends AppState {
  const AppInitializingState() : super(breeds: const []);
}
