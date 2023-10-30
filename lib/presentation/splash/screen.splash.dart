library splash;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../app.dart';
import '../../application/app_bloc/app_bloc.dart';
import '../../infrastructure/config/routes/app.route_names.dart';
import '../../infrastructure/utils/app.sizes.dart';
import '../../infrastructure/utils/app.utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) => BlocConsumer<AppBloc, AppState>(
        listener: (final context, final state) {
          if (state is InitializedState) {
            App.navigator?.pushReplacementNamed(AppRouteNames.home);
          }
        },
        builder: (final context, final state) {
          final themeData = Theme.of(context);

          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLogo(themeData),
                AppUtils.verticalSpacer(),
                buildStateInfo(state, themeData),
                if (state is ErrorState) buildRetryButton(context, themeData),
              ],
            ),
          );
        },
      );

  Widget _buildRetryButton(
    final BuildContext context,
    final ThemeData themeData,
  ) =>
      TextButton(
        onPressed: () {
          BlocProvider.of<AppBloc>(context).add(FetchBreeds());
        },
        child: Text(
          'Retry',
          style: themeData.textTheme.labelLarge,
        ),
      );

  Widget _buildStateInfo(final AppState state, final ThemeData themeData) =>
      Text(
        state is InitializingState
            ? "Initializing Doggo's Den"
            : state is FetchingBreedsState
                ? 'Dog whistle noises in background...'
                : state is ErrorState
                    ? 'Error occurred'
                    : 'Done',
        style: themeData.textTheme.bodyLarge
            ?.copyWith(color: themeData.colorScheme.onBackground),
      );

  Widget buildLogo(final ThemeData themeData) => SizedBox(
        height: AppSizes.points_64 * 10,
        child: SvgPicture.asset(
          '${AppUtils.imageAssetsPath}doggo.svg',
          colorFilter: ColorFilter.mode(
            themeData.colorScheme.onBackground,
            BlendMode.srcIn,
          ),
        ),
      );
}
