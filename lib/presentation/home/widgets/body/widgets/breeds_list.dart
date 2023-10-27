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

    return Material(
      elevation: AppElevations.level_2,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.points_8),
        decoration: BoxDecoration(color: themeData.colorScheme.background),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: breeds.length,
          itemBuilder: (final context, final index) => Container(
            width: AppSizes.points_64 * 2,
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: hasSubBreed(breeds, index)
                  ? () {
                      Body.state(context)?.setSubBreedsList(
                        subBreeds: breeds[index].subBreeds,
                        activeBreed: breeds[index].name,
                      );
                    }
                  : null,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      breeds[index].name.capitalize(),
                      style: themeData.textTheme.labelLarge?.copyWith(
                        color: themeData.colorScheme.onBackground,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      Body.state(context)?.setImages(
                        await BlocProvider.of<AppBloc>(context)
                            .getAllImagesByBreed(
                          breeds[index].name,
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
                            .getRandomByBreed(
                          breeds[index].name,
                        ),
                      );
                    },
                    icon: const Tooltip(
                      waitDuration: Duration(milliseconds: 450),
                      message: 'Random Image',
                      child: Icon(Icons.radar),
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.points_40,
                    child: (hasSubBreed(breeds, index))
                        ? const Icon(Icons.keyboard_arrow_right)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool hasSubBreed(final List<Breed> breeds, final int index) =>
      breeds[index].subBreeds.isNotEmpty;
}
