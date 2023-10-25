import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app.dart';
import '../../infrastructure/config/routes/app.route_names.dart';
import '../../infrastructure/config/theme/app.fonts.dart';
import '../../infrastructure/utils/app.sizes.dart';
import '../../infrastructure/utils/app.utils.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: AppUtils.responsiveContent(
          context: context,
          isScrollable: false,
          child: NestedScrollView(
            controller: ScrollController(),
            headerSliverBuilder: (final context, final innerBoxIsScrolled) =>
                [const HomeHeader()],
            body: const Placeholder(),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.points_16,
            horizontal: AppSizes.points_32,
          ),
          decoration: BoxDecoration(
            color: App.theme.colorScheme.background,
            border: Border(
              top: BorderSide(
                color: App.theme.colorScheme.primary,
                width: .5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Built upon ',
                      style: App.theme.textTheme.labelLarge?.copyWith(
                        color: App.theme.colorScheme.onPrimary,
                      ),
                    ),
                    TextSpan(
                        text: 'Dog.Ceo',
                        style: App.theme.textTheme.labelLarge?.copyWith(
                          color: App.theme.colorScheme.onPrimary,
                          decoration: TextDecoration.underline,
                          fontWeight: AppFonts.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ],
                ),
              ),
              AppUtils.horizontalSpacer(),
              SvgPicture.asset(
                '${AppUtils.imageAssetsPath}doggo.svg',
                height: AppSizes.points_32,
                colorFilter: ColorFilter.mode(
                  App.theme.colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
                theme: SvgTheme(
                  currentColor: App.theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      );
}

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
    final titleStyle = App.theme.textTheme.displayLarge;
    final titleSize =
        titleStyle!.fontSize! * ((maxExtent - shrinkOffset) / maxExtent);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.points_8),
      decoration: BoxDecoration(
        color: App.theme.colorScheme.background,
        border: Border(
          bottom: BorderSide(color: App.theme.colorScheme.primary, width: .5),
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
                        color: App.theme.colorScheme.primary,
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
                    style: App.theme.textTheme.titleSmall
                        ?.copyWith(color: App.theme.colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Random Doggo',
                  style: App.theme.textTheme.labelLarge
                      ?.copyWith(color: App.theme.colorScheme.secondary),
                ),
              ),
            ],
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
