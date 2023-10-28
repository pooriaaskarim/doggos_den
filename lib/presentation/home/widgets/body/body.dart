part of home;

class Body extends StatefulWidget {
  const Body({
    super.key,
  });
  static BodyState? state(final BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BodyData>()?.state;
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  final _willPopDuration = const Duration(seconds: 3);
  int _willPopRetries = 0;

  @override
  void dispose() {
    BlocProvider.of<DoggoBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => DoggoBloc(
          doggoRepository: RepositoryProvider.of<DoggoRepository>(context),
        ),
        child: BlocBuilder<AppBloc, AppState>(
          builder: (final context, final appState) {
            final breeds = appState.breeds;
            final ThemeData themeData = Theme.of(context);

            return BlocBuilder<DoggoBloc, DoggoState>(
              builder: (final context, final doggoState) {
                final activeSubBreed = doggoState.activeSubBreed;
                final activeBreed = doggoState.activeBreed;
                final images = doggoState.images;

                return BodyData(
                  state: this,
                  child: WillPopScope(
                    onWillPop: () async {
                      if (activeSubBreed != null) {
                        BlocProvider.of<DoggoBloc>(context).clearSubBreed();
                        return false;
                      } else if (activeBreed != null) {
                        BlocProvider.of<DoggoBloc>(context).clearBreed();
                        return false;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Press BACK again to exit',
                            ),
                            duration: _willPopDuration,
                          ),
                        );
                        _willPopRetries++;
                        debugPrint(_willPopRetries.toString());
                        unawaited(
                          Future.delayed(_willPopDuration)
                              .then((final value) => _willPopRetries = 0),
                        );
                      }
                      return _willPopRetries > 1;
                    },
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          alignment: AlignmentDirectional.topStart,
                          child: BreedsList(
                            breeds: breeds,
                          ),
                        ),
                        if (activeSubBreed != null || activeBreed != null)
                          LayoutBuilder(
                            builder: (final context, final constraints) =>
                                Container(
                              color: Colors.transparent,
                              child: Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: SizedBox(
                                  width: constraints.maxWidth * 0.9,
                                  child: Material(
                                    elevation: AppElevations.level_4,
                                    child: Ink(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.points_8,
                                        vertical: AppSizes.points_4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: themeData.colorScheme.background,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const BackButton(),
                                              AppUtils.horizontalSpacer(),
                                              Text(
                                                '${activeBreed?.name.capitalize() ?? ''}/${activeSubBreed?.name.capitalize() ?? ''}',
                                                style: themeData
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                  fontWeight: AppFonts.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: doggoState is DoggoIdleState
                                                ? (images != null)
                                                    ? ImagesList(images: images)
                                                    : (activeBreed != null)
                                                        ? SubBreedsList(
                                                            breed: activeBreed,
                                                          )
                                                        : doggoState
                                                                is DoggoLoadingState
                                                            ? const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              )
                                                            : const Text(
                                                                'Error',
                                                              )
                                                : const SizedBox.shrink(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
}

class BodyData extends InheritedWidget {
  const BodyData({
    required super.child,
    required this.state,
    super.key,
  });

  final BodyState state;

  @override
  bool updateShouldNotify(covariant final BodyData oldWidget) =>
      oldWidget.state != state;
}
