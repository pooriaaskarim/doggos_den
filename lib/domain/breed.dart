import 'package:equatable/equatable.dart';

abstract class BreedBase extends Equatable {
  const BreedBase({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}

class Breed extends BreedBase {
  const Breed({required super.name, required this.subBreeds});

  final List<SubBreed> subBreeds;
}

class SubBreed extends BreedBase {
  const SubBreed({required super.name});
}
