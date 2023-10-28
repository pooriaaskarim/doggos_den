part of home;

class ImagesList extends StatelessWidget {
  const ImagesList({
    required this.images,
    super.key,
  });

  final List<String> images;

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
      itemCount: images.length,
      itemBuilder: (final context, final index) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.points_16,
          horizontal: AppSizes.points_8,
        ),
        child: buildImage(index, themeData),
      ),
    );
  }

  Widget buildImage(final int index, final ThemeData themeData) =>
      Image.network(
        images[index],
        errorBuilder: (final context, final error, final stackTrace) => Center(
          child: Text(
            "Couldn't load image",
            style: themeData.textTheme.bodyLarge,
          ),
        ),
        loadingBuilder: (final context, final child, final loadingProgress) =>
            (loadingProgress != null)
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
                : child,
        frameBuilder: (
          final context,
          final child,
          final frame,
          final wasSynchronouslyLoaded,
        ) =>
            Center(
          child: Material(
            type: MaterialType.card,
            elevation: AppElevations.level_5,
            child: Stack(
              fit: StackFit.loose,
              children: [
                child,
                Positioned(
                  bottom: AppSizes.points_8,
                  right: AppSizes.points_8,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (final context) => Dialog.fullscreen(
                          child: Scaffold(
                            appBar: AppBar(),
                            body: AppUtils.responsiveContent(
                              context: context,
                              child: child,
                            ),
                          ),
                        ),
                      );
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        color:
                            themeData.colorScheme.background.withOpacity(0.6),
                      ),
                      child: Icon(
                        Icons.fullscreen,
                        color: themeData.colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
