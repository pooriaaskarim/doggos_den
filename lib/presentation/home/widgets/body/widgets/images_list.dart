part of home;

class ImagesList extends StatelessWidget {
  const ImagesList({
    required this.images,
    // required this.breed,
    // required this.subBreed,
    super.key,
  });

  // final String breed;
  // final String subBreed;
  final List<String> images;
  @override
  Widget build(final BuildContext context) {
    final themeData = Theme.of(context);

    return Material(
      elevation: AppElevations.level_5,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.points_8),
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Body.state(context)?.setImages(null);
                  },
                  icon: const Icon(Icons.arrow_back_sharp),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: true,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.points_16,
                  horizontal: AppSizes.points_8,
                ),
                itemCount: images.length,
                itemBuilder: (final context, final index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.points_16,
                      horizontal: AppSizes.points_8,
                    ),
                    child: Image.network(images[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
