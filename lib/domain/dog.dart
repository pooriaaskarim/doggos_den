import 'package:equatable/equatable.dart';

import 'breed.dart';

class Dog extends Equatable {
  const Dog({required this.breed});

  final Breed breed;

  @override
  List<Object?> get props => [
        breed,
      ];
}
