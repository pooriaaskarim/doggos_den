part of home;

class SubBreedsList extends StatelessWidget {
  const SubBreedsList({
    required this.breed,
    super.key,
  });

  final Breed breed;

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
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.points_16,
        horizontal: AppSizes.points_8,
      ),
      itemCount: breed.subBreeds.length,
      itemBuilder: (final context, final index) {
        final subBreed = breed.subBreeds[index];

        return Container(
          width: AppSizes.points_64 * 2,
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  subBreed.name.capitalize(),
                  style: themeData.textTheme.labelLarge?.copyWith(
                    color: themeData.colorScheme.onBackground,
                  ),
                ),
              ),
              doggosImageListButton(
                onFetchImages: () async {
                  await BlocProvider.of<DoggoCubit>(context)
                      .fetchAllImagesBySubBreed(breed, subBreed);
                },
              ),
              doggoRandomImagesButton(
                onFetchImages: () {
                  BlocProvider.of<DoggoCubit>(context)
                      .fetchRandomBySubBreed(breed, subBreed);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
