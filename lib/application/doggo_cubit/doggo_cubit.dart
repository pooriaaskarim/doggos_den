import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/breed.dart';
import '../../infrastructure/repositories/network/doggo.repository.dart';

part 'doggo_state.dart';

/// Handles selecting [Breed]s and [SubBreed] and loading Doggo images
class DoggoCubit extends Cubit<DoggoState> {
  DoggoCubit({
    required final DoggoRepository doggoRepository,
  })  : _doggoRepository = doggoRepository,
        super(
          const DoggoIdleState(),
        );

  final DoggoRepository _doggoRepository;

  /// sets a [Breed] as activeBreed
  void setBreed(
    final Breed breed,
  ) {
    emit(
      DoggoIdleState(
        activeBreed: breed,
      ),
    );
  }

  /// Clears activeBreed, activeSubBreed and imagesList
  void clearBreed() {
    emit(
      const DoggoIdleState(),
    );
  }

  /// Clears activeSubBreed and imagesList
  void clearSubBreed() {
    emit(
      DoggoIdleState(
        activeBreed: state.activeBreed,
      ),
    );
  }

  /// Sets activeBreed and loads all images based on that [Breed]
  Future<void> fetchAllImagesByBreed(final Breed breed) async {
    emit(DoggoLoadingState(activeBreed: breed));

    final images =
        await _doggoRepository.getAllImagesByBreed(state.activeBreed!.name);
    return images.fold(
      (final l) {
        emit(
          DoggoErrorState(
            activeSubBreed: state.activeSubBreed,
            activeBreed: state.activeBreed,
            error: l,
          ),
        );

        throw l;
      },
      (final r) {
        final images = (r.data['message'] as List<dynamic>)
            .map((final e) => e as String)
            .toList();

        emit(
          DoggoIdleState(
            activeSubBreed: state.activeSubBreed,
            activeBreed: state.activeBreed,
            images: images,
          ),
        );
      },
    );
  }

  /// Sets activeBreed and subBreed, then loads all image based on that [Breed]/[SubBreed]
  Future<void> fetchAllImagesBySubBreed(
    final Breed breed,
    final SubBreed subBreed,
  ) async {
    emit(
      DoggoLoadingState(
        activeBreed: breed,
        activeSubBreed: subBreed,
      ),
    );
    final images = await _doggoRepository.getAllImagesBySubBreed(
      state.activeBreed!.name,
      state.activeSubBreed!.name,
    );

    return images.fold(
      (final l) {
        emit(
          DoggoErrorState(
            activeSubBreed: state.activeSubBreed,
            activeBreed: state.activeBreed,
            error: l,
          ),
        );

        throw l;
      },
      (final r) {
        final images = (r.data['message'] as List<dynamic>)
            .map((final e) => e as String)
            .toList();

        emit(
          DoggoIdleState(
            activeSubBreed: state.activeSubBreed,
            activeBreed: state.activeBreed,
            images: images,
          ),
        );
      },
    );
  }

  /// Sets activeBreed and loads random image based on that [Breed]
  Future<void> fetchRandomByBreed(
    final Breed breed,
  ) async {
    emit(DoggoLoadingState(activeBreed: breed));

    final images =
        await _doggoRepository.getRandomByBreed(state.activeBreed!.name);

    return images.fold(
      (final l) {
        emit(
          DoggoErrorState(
            activeSubBreed: state.activeSubBreed,
            activeBreed: state.activeBreed,
            error: l,
          ),
        );

        throw l;
      },
      (final r) {
        final images = (r.data['message'] as List<dynamic>)
            .map((final e) => e as String)
            .toList();

        emit(
          DoggoIdleState(
            activeSubBreed: state.activeSubBreed,
            activeBreed: state.activeBreed,
            images: images,
          ),
        );
      },
    );
  }

  /// Sets activeBreed and subBreed, then loads random image based on that [Breed]/[SubBreed]
  Future<void> fetchRandomBySubBreed(
    final Breed breed,
    final SubBreed subBreed,
  ) async {
    emit(DoggoLoadingState(activeBreed: breed, activeSubBreed: subBreed));

    final images = await _doggoRepository.getRandomBySubBreed(
      state.activeBreed!.name,
      state.activeSubBreed!.name,
    );

    return images.fold((final l) {
      emit(
        DoggoErrorState(
          activeSubBreed: state.activeSubBreed,
          activeBreed: state.activeBreed,
          error: l,
        ),
      );

      throw l;
    }, (final r) {
      final images = (r.data['message'] as List<dynamic>)
          .map((final e) => e as String)
          .toList();

      emit(
        DoggoIdleState(
          activeSubBreed: state.activeSubBreed,
          activeBreed: state.activeBreed,
          images: images,
        ),
      );
    });
  }
}
