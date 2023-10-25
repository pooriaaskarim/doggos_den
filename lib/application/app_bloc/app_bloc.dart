import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/breed.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitializingState()) {
    on<AppEvent>((final event, final emit) {
      // TODO: implement event handler
    });
  }
}
