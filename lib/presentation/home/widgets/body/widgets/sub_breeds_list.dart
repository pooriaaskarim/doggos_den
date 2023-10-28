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

    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.points_16,
        horizontal: AppSizes.points_8,
      ),
      itemCount: breed.subBreeds.length,
      itemBuilder: (final context, final index) => Container(
        width: AppSizes.points_64 * 2,
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            Expanded(
              child: Text(
                breed.subBreeds[index].name.capitalize(),
                style: themeData.textTheme.labelLarge?.copyWith(
                  color: themeData.colorScheme.onBackground,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<DoggoBloc>(context)
                    .fetchAllImagesBySubBreed(breed, breed.subBreeds[index]);
              },
              icon: const Tooltip(
                waitDuration: Duration(milliseconds: 450),
                message: 'List All Images',
                child: Icon(Icons.list),
              ),
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<DoggoBloc>(context)
                    .fetchRandomBySubBreed(breed, breed.subBreeds[index]);
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
    );
  }
}
