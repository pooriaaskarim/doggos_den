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
  List<SubBreed>? _activeSubBreeds;
  List<String>? _activeImages;
  String? _activeBreed;
  void setSubBreedsList({
    required final List<SubBreed>? subBreeds,
    required final String? activeBreed,
  }) {
    setState(() {
      _activeBreed = activeBreed;
      _activeSubBreeds = subBreeds;
    });
  }

  void setImages(final List<String>? images) {
    setState(() {
      _activeImages = images;
    });
  }

  @override
  Widget build(final BuildContext context) => BodyData(
        state: this,
        child: BlocBuilder<AppBloc, AppState>(
          builder: (final context, final state) {
            final breeds = state.breeds;

            return LayoutBuilder(
              builder: (final context, final constraints) => Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    child: BreedsList(
                      breeds: breeds,
                    ),
                  ),
                  if (_activeSubBreeds != null)
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: SizedBox(
                        width: constraints.maxWidth * 0.9,
                        child: SubBreedsList(
                          breed: _activeBreed!,
                          subBreeds: _activeSubBreeds!,
                        ),
                      ),
                    ),
                  if (_activeImages != null)
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: SizedBox(
                        width: constraints.maxWidth * 0.9,
                        child: ImagesList(
                          images: _activeImages!,
                        ),
                      ),
                    ),
                ],
              ),
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
