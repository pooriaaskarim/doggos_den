library home;

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/app_bloc/app_bloc.dart';
import '../../application/doggo_cubit/doggo_cubit.dart';
import '../../domain/models/breed.dart';
import '../../infrastructure/config/theme/app.elevations.dart';
import '../../infrastructure/config/theme/app.fonts.dart';
import '../../infrastructure/repositories/network/doggo.repository.dart';
import '../../infrastructure/utils/app.sizes.dart';
import '../../infrastructure/utils/app.utils.dart';
import '../shared/widgets/loading.dart';

part 'widgets/body/body.dart';
part 'widgets/body/widgets/list.breeds.dart';
part 'widgets/body/widgets/list.images.dart';
part 'widgets/body/widgets/list.sub_breeds.dart';
part 'widgets/footer/footer.dart';
part 'widgets/header/header.dart';
part 'widgets/header/widgets/button.theme_toggle.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static ScrollController scrollController = ScrollController();
  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (final context, final innerBoxIsScrolled) => [
              const HomeHeader(),
            ],
            body: Padding(
              padding: AppUtils.responsiveHorizontalPadding(context),
              child: const Body(),
            ),
          ),
          bottomNavigationBar: const Footer(),
        ),
      );
}
