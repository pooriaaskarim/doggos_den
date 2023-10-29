part of 'doggo_cubit.dart';

abstract class DoggoState extends Equatable {
  const DoggoState({
    required this.images,
    this.activeBreed,
    this.activeSubBreed,
  });

  final Breed? activeBreed;
  final SubBreed? activeSubBreed;
  final List<String>? images;

  @override
  List<Object?> get props => [
        activeBreed,
        activeSubBreed,
        images,
      ];
}

///DoggoState: Waiting for action
class DoggoIdleState extends DoggoState {
  const DoggoIdleState({
    super.images,
    super.activeBreed,
    super.activeSubBreed,
  });
}

///DoggoState: Some action was called and Cubit is waiting for it to finish
class DoggoLoadingState extends DoggoState {
  const DoggoLoadingState({
    super.images,
    super.activeBreed,
    super.activeSubBreed,
  });
}

///DoggoState: Some action was called and Cubit encountered error
class DoggoErrorState extends DoggoState {
  const DoggoErrorState({
    required this.error,
    super.images,
    super.activeBreed,
    super.activeSubBreed,
  });
  final Exception error;

  @override
  List<Object?> get props => [
        activeBreed,
        activeSubBreed,
        images,
        error,
      ];
}
