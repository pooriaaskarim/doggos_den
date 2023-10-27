part of home;

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.points_16,
        horizontal: AppSizes.points_32,
      ),
      decoration: BoxDecoration(
        color: themeData.colorScheme.background,
        border: Border(
          top: BorderSide(
            color: themeData.colorScheme.primary,
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
                  style: themeData.textTheme.labelLarge?.copyWith(
                    color: themeData.colorScheme.onBackground,
                  ),
                ),
                TextSpan(
                  text: 'Dog.Ceo',
                  style: themeData.textTheme.labelLarge?.copyWith(
                    color: themeData.colorScheme.onBackground,
                    decoration: TextDecoration.underline,
                    fontWeight: AppFonts.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
          AppUtils.horizontalSpacer(),
          SvgPicture.asset(
            '${AppUtils.imageAssetsPath}dog_ceo.svg',
            height: AppSizes.points_32,
            colorFilter: ColorFilter.mode(
              themeData.colorScheme.onBackground,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
