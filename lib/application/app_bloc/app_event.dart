part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class InitializeApp extends AppEvent {
  @override
  List<Object?> get props => [];
}
