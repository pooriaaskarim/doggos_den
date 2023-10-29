part of home;

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    const willPopDuration = Duration(seconds: 3);
    int willPopRetries = 0;

    return BlocProvider(
      create: (final context) => DoggoCubit(
        doggoRepository: RepositoryProvider.of<DoggoRepository>(context),
      ),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (final context, final appState) {
          final breeds = appState.breeds;
          final ThemeData themeData = Theme.of(context);

          return BlocBuilder<DoggoCubit, DoggoState>(
            builder: (final context, final doggoState) {
              final doggoCubit = BlocProvider.of<DoggoCubit>(context);

              final activeSubBreed = doggoState.activeSubBreed;
              final activeBreed = doggoState.activeBreed;
              final images = doggoState.images;

              return WillPopScope(
                onWillPop: () async {
                  if (activeSubBreed != null) {
                    doggoCubit.clearSubBreed();
                    return false;
                  } else if (activeBreed != null) {
                    doggoCubit.clearBreed();
                    return false;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Press BACK again to exit',
                        ),
                        duration: willPopDuration,
                      ),
                    );
                    willPopRetries++;
                    debugPrint(willPopRetries.toString());
                    unawaited(
                      Future.delayed(willPopDuration)
                          .then((final value) => willPopRetries = 0),
                    );
                  }
                  return willPopRetries > 1;
                },
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    BreedsList(
                      breeds: breeds,
                    ),
                    if (_shouldShowSidePanel(
                      activeSubBreed,
                      activeBreed,
                      doggoState,
                    ))
                      LayoutBuilder(
                        builder: (final context, final constraints) =>
                            Container(
                          alignment: AlignmentDirectional.topEnd,
                          color: Colors.transparent,
                          child: Material(
                            elevation: AppElevations.level_4,
                            child: Ink(
                              width: constraints.maxWidth * 0.9,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.points_8,
                                vertical: AppSizes.points_4,
                              ),
                              decoration: BoxDecoration(
                                color: themeData.colorScheme.background,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTitle(
                                    activeBreed,
                                    activeSubBreed,
                                    themeData,
                                  ),
                                  Expanded(
                                    child: doggoState is DoggoIdleState
                                        ? _buildIdlePanel(images, activeBreed)
                                        : doggoState is DoggoLoadingState
                                            ? _buildLoadingPanel()
                                            : doggoState is DoggoErrorState
                                                ? _buildErrorPanel()
                                                : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildIdlePanel(
          final List<String>? images, final Breed? activeBreed) =>
      (images != null)
          ? ImagesList(images: images)
          : (activeBreed != null)
              ? SubBreedsList(
                  breed: activeBreed,
                )
              : const SizedBox.shrink();

  Widget _buildLoadingPanel() => const Center(
        child: Loading(
          message: 'Loading Image(s) ...',
        ),
      );

  Widget _buildErrorPanel() => const Center(
        child: Text(
          'Error occurred, please try again!',
        ),
      );

  Widget _buildTitle(
    final Breed? activeBreed,
    final SubBreed? activeSubBreed,
    final ThemeData themeData,
  ) =>
      Row(
        children: [
          const BackButton(),
          AppUtils.horizontalSpacer(),
          Text(
            '${activeBreed?.name.capitalize() ?? ''}/${activeSubBreed?.name.capitalize() ?? ''}',
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: AppFonts.bold,
            ),
          ),
        ],
      );

  bool _shouldShowSidePanel(
    final SubBreed? activeSubBreed,
    final Breed? activeBreed,
    final DoggoState doggoState,
  ) =>
      (doggoState is DoggoIdleState &&
          (activeSubBreed != null || activeBreed != null)) ||
      doggoState is DoggoErrorState ||
      doggoState is DoggoLoadingState;
}

///IconButton to retrieve random Images
Widget doggoRandomImagesButton({
  required final void Function() onFetchImages,
}) =>
    IconButton(
      onPressed: onFetchImages,
      icon: const Tooltip(
        waitDuration: Duration(milliseconds: 450),
        message: 'Random Image',
        child: Icon(Icons.shuffle),
      ),
    );

///IconButton to retrieve Images List
Widget doggosImageListButton({required final Function() onFetchImages}) =>
    IconButton(
      onPressed: onFetchImages,
      icon: const Tooltip(
        waitDuration: Duration(milliseconds: 450),
        message: 'List All Images',
        child: Icon(Icons.list),
      ),
    );
