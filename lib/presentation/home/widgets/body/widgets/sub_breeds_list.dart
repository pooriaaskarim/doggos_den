part of home;

class SubBreedsList extends StatelessWidget {
  const SubBreedsList({
    required this.breed,
    required this.subBreeds,
    super.key,
  });

  final List<SubBreed> subBreeds;
  final String breed;
  @override
  Widget build(final BuildContext context) {
    final themeData = Theme.of(context);

    return Material(
      elevation: AppElevations.level_4,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.points_8),
        decoration: BoxDecoration(color: themeData.colorScheme.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Body.state(context)?.setSubBreedsList(
                      activeBreed: null,
                      subBreeds: null,
                    );
                  },
                  icon: const Icon(Icons.arrow_back_sharp),
                ),
                AppUtils.horizontalSpacer(),
                Text(
                  breed.capitalize(),
                  style: themeData.textTheme.titleMedium?.copyWith(
                    fontWeight: AppFonts.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.points_16,
                  horizontal: AppSizes.points_8,
                ),
                itemCount: subBreeds.length,
                itemBuilder: (final context, final index) => Container(
                  width: AppSizes.points_64 * 2,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          subBreeds[index].name.capitalize(),
                          style: themeData.textTheme.labelLarge?.copyWith(
                            color: themeData.colorScheme.onBackground,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Body.state(context)?.setImages(
                            await BlocProvider.of<AppBloc>(context)
                                .getAllImagesBySubBreed(
                              breed,
                              subBreeds[index].name,
                            ),
                          );
                        },
                        icon: const Tooltip(
                          waitDuration: Duration(milliseconds: 450),
                          message: 'List All Images',
                          child: Icon(Icons.list),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Body.state(context)?.setImages(
                            await BlocProvider.of<AppBloc>(context)
                                .getRandomBySubBreed(
                              breed,
                              subBreeds[index].name,
                            ),
                          );
                        },
                        icon: const Tooltip(
                          waitDuration: Duration(milliseconds: 450),
                          message: 'Random Image',
                          child: Icon(Icons.radar),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
