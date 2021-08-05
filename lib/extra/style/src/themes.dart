part of style;

mixin Themes {
  static void initUiOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Palette.mineshaft,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(
        primary: Palette.aquaHaze,
        secondary: Palette.aquaHaze,
        primaryVariant: Palette.aquaHaze,
        secondaryVariant: Palette.aquaHaze,
        background: Palette.aquaHaze,
        onPrimary: Palette.mineshaft,
        onSecondary: Palette.mineshaft,
      ),
      scaffoldBackgroundColor: Palette.aquaHaze,
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        backgroundColor: Palette.aquaHaze,
        actionsIconTheme: IconThemeData(
          color: Palette.mineshaft,
        ),
        iconTheme: IconThemeData(
          color: Palette.mineshaft,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Palette.mineshaft,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark(
        primary: Palette.mineshaft,
        secondary: Palette.mineshaft,
        primaryVariant: Palette.mineshaft,
        secondaryVariant: Palette.mineshaft,
        background: Palette.mineshaft,
        onPrimary: Palette.aquaHaze,
        onSecondary: Palette.aquaHaze,
      ),
      scaffoldBackgroundColor: Palette.mineshaft,
      appBarTheme: const AppBarTheme(
        backgroundColor: Palette.mineshaft,
        actionsIconTheme: IconThemeData(
          color: Palette.aquaHaze,
        ),
        iconTheme: IconThemeData(
          color: Palette.aquaHaze,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Palette.aquaHaze,
      ),
    );
  }
}
