part of home;

class BreedsList extends StatelessWidget {
  const BreedsList({
    required this.breeds,
    super.key,
  });
  final List<Breed> breeds;

  @override
  Widget build(final BuildContext context) {
    final themeData = Theme.of(context);
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.minScrollExtent) {
        Home.scrollController
            .animateTo(0, duration: Durations.short1, curve: Curves.bounceOut);
      }
    });

    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      itemCount: breeds.length,
      itemBuilder: (final context, final index) {
        final breed = breeds[index];

        return Container(
          width: AppSizes.points_64 * 2,
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: hasSubBreed(breed)
                ? () {
                    BlocProvider.of<DoggoCubit>(context).setBreed(breed);
                  }
                : null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    breed.name.capitalize(),
                    style: themeData.textTheme.labelLarge?.copyWith(
                      color: themeData.colorScheme.onBackground,
                    ),
                  ),
                ),
                doggosImageListButton(
                  onFetchImages: () async {
                    await BlocProvider.of<DoggoCubit>(context)
                        .fetchAllImagesByBreed(breed);
                  },
                ),
                doggoRandomImagesButton(
                  onFetchImages: () async {
                    await BlocProvider.of<DoggoCubit>(context)
                        .fetchRandomByBreed(breed);
                  },
                ),
                SizedBox(
                  width: AppSizes.points_40,
                  child: (hasSubBreed(breed))
                      ? Icon(
                          Icons.keyboard_arrow_right,
                          color: themeData.colorScheme.onBackground,
                        )
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool hasSubBreed(
    final Breed breed,
  ) =>
      breed.subBreeds.isNotEmpty;
}
