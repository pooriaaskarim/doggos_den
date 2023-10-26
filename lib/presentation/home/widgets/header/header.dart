part of home;

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(final BuildContext context) => SliverPersistentHeader(
        delegate: HomeHeaderDelegate(),
        pinned: true,
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

    final titleStyle = themeData.textTheme.displayLarge;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      App.navigator?.pushNamed(AppRouteNames.home);
                    },
                    child: Text(
                      "Doggo's Den",
                      style: titleStyle.copyWith(
                        color: themeData.colorScheme.primary,
                        fontSize: titleSize >= AppSizes.points_24
                            ? titleSize
                            : AppSizes.points_24,
                      ),
                    ),
                  ),
                ),
                AppUtils.verticalSpacer(AppSizes.points_8),
                Center(
                  child: Text(
                    'A Showroom for all earth Doggos!',
                    style: themeData.textTheme.titleSmall
                        ?.copyWith(color: themeData.colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: AppUtils.responsiveHorizontalPadding(context),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Random Doggo',
                    style: themeData.textTheme.labelLarge
                        ?.copyWith(color: themeData.colorScheme.secondary),
                  ),
                ),
                Expanded(child: AppUtils.horizontalSpacer()),
                const ThemeToggleButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => AppSizes.points_64 * 3;

  @override
  double get minExtent => AppSizes.points_64 * 2;

  @override
  bool shouldRebuild(
    covariant final SliverPersistentHeaderDelegate oldDelegate,
  ) =>
      false;
}
