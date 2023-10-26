library home;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../app.dart';
import '../../application/app_bloc/app_bloc.dart';
import '../../infrastructure/config/routes/app.route_names.dart';
import '../../infrastructure/config/theme/app.fonts.dart';
import '../../infrastructure/utils/app.sizes.dart';
import '../../infrastructure/utils/app.utils.dart';

part 'widgets/header/Footer.dart';
part 'widgets/header/header.dart';
part 'widgets/header/widgets/button.theme_toggle.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (final context, final innerBoxIsScrolled) => [
            const HomeHeader(),
          ],
          body: Padding(
            padding: AppUtils.responsiveHorizontalPadding(context),
            child: const Placeholder(),
          ),
        ),
        bottomNavigationBar: const Footer(),
      );
}
