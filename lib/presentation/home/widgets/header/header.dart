part of home;

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(final BuildContext context) => SliverPersistentHeader(
        delegate: HomeHeaderDelegate(),
        pinned: true,
        floating: true,
      );
}

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    final BuildContext context,
    final double shrinkOffset,
    final bool overlapsContent,
  ) {
    final themeData = Theme.of(context);

    final titleStyle = themeData.textTheme.displaySmall;
    final titleSize =
        titleStyle!.fontSize! * ((maxExtent - shrinkOffset) / maxExtent);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.points_8),
      decoration: BoxDecoration(
        color: themeData.colorScheme.background,
        border: Border(
          bottom: BorderSide(color: themeData.colorScheme.primary, width: .5),
        ),
      ),
      child: Padding(
        padding: AppUtils.responsiveHorizontalPadding(context).add(
          const EdgeInsets.symmetric(
            vertical: AppSizes.points_12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Doggo's Den",
                    style: titleStyle.copyWith(
                      color: themeData.colorScheme.primary,
                      fontSize: titleSize >= AppSizes.points_24
                          ? titleSize
                          : AppSizes.points_24,
                    ),
                  ),
                  if (shrinkOffset == 0)
                    Text(
                      '\n\nA Showroom for all earth Doggos!',
                      style: themeData.textTheme.bodySmall
                          ?.copyWith(color: themeData.colorScheme.secondary),
                    ),
                ],
              ),
            ),
            const ThemeToggleButton(),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => AppSizes.points_64 * 2;

  @override
  double get minExtent => AppSizes.points_64;

  @override
  bool shouldRebuild(
    covariant final SliverPersistentHeaderDelegate oldDelegate,
  ) =>
      true;
}
