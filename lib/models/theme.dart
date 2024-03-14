import 'package:flutter/material.dart';

/// {@template models.theme.colorScheme}
/// By pulling colors from the `colorScheme`, the color palette can adapt
/// based on whether the app is in light or dark mode.
///
/// ```dart
/// Widget build(BuildContext context) {
///   final colorScheme = Theme.of(context).colorScheme;
///   return ColoredBox(
///     color: colorScheme.surface,
///     child: Text(
///       'Hello World',
///       style: TextStyle(color: colorScheme.onSurface),
///     ),
///   );
/// }
/// ```
///
/// The THC app colors are based on the color palette from
/// [theheartcenter.one](https://theheartcenter.one/).
/// {@endtemplate}
abstract final class ThcColors {
  static const green = Color(0xff99cc99);
  static const pink = Color(0xffeecce0);
  static const orange = Color(0xffffa020);
  static const teal = Color(0xff00b0b0);
  static const tan = Color(0xfff8f0e0);
  static const dullBlue = Color(0xff364764);
  static const darkBlue = Color(0xff151c28);
  static const darkGreen = Color(0xff003300);
  static const darkMagenta = Color(0xff663366);
  static const paleAzure = Color(0xffddeeff);
}

const buttonStyle = ButtonStyle(shape: MaterialStatePropertyAll(BeveledRectangleBorder()));

final navigationBarTheme = NavigationBarThemeData(
  backgroundColor: ThcColors.darkBlue,
  labelTextStyle: MaterialStateProperty.resolveWith((states) {
    const style = TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: ThcColors.teal);
    if (states.contains(MaterialState.selected)) return style;
    return style.copyWith(color: Colors.white);
  }),
  indicatorColor: Colors.transparent,
  iconTheme: MaterialStateProperty.resolveWith((states) {
    const data = IconThemeData(size: 32, color: ThcColors.teal);
    if (states.contains(MaterialState.selected)) return data;
    return data.copyWith(color: Colors.white);
  }),
  labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
);

extension type ThemeScheme.fromData(ThemeData data) implements ThemeData {
  ThemeScheme(ColorScheme scheme)
      : this.fromData(ThemeData(
          colorScheme: scheme,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          filledButtonTheme: const FilledButtonThemeData(style: buttonStyle),
          elevatedButtonTheme: const ElevatedButtonThemeData(style: buttonStyle),
          navigationBarTheme: navigationBarTheme,
        ));
}

/// {@macro models.theme.colorScheme}
final lightTheme = ThemeScheme(
  const ColorScheme(
    brightness: Brightness.light,
    primary: ThcColors.green,
    inversePrimary: ThcColors.darkGreen,
    onPrimary: Colors.white,
    secondary: ThcColors.teal,
    onSecondary: Colors.white,
    tertiary: ThcColors.darkMagenta,
    onTertiary: ThcColors.tan,
    error: Colors.red,
    onError: Colors.white,
    errorContainer: ThcColors.pink,
    onErrorContainer: Colors.red,
    background: ThcColors.paleAzure,
    onBackground: Colors.black,
    surface: ThcColors.tan,
    onSurface: Colors.black,
    surfaceVariant: ThcColors.dullBlue,
    onSurfaceVariant: Colors.white,
    inverseSurface: ThcColors.darkBlue,
    onInverseSurface: ThcColors.orange,
  ),
);

/// {@macro models.theme.colorScheme}
final darkTheme = ThemeScheme(
  const ColorScheme(
    brightness: Brightness.dark,
    primary: ThcColors.green,
    onPrimary: Colors.white,
    primaryContainer: ThcColors.darkGreen,
    onPrimaryContainer: Colors.white,
    secondary: ThcColors.teal,
    onSecondary: Colors.white,
    tertiary: ThcColors.tan,
    onTertiary: ThcColors.darkMagenta,
    error: Colors.red,
    onError: Colors.white,
    background: ThcColors.darkBlue,
    onBackground: ThcColors.paleAzure,
    surface: ThcColors.dullBlue,
    onSurface: ThcColors.paleAzure,
  ),
);

/// `extension` lets you add methods to a class, as if you were
/// doing it inside the class definition.
///
/// {@template models.theme.ThemeGetter}
/// This extension makes fetching the color scheme a bit cleaner.
///
/// ```dart
/// ColoredBox(color: Theme.of(context).colorScheme.surface) // before
/// ColoredBox(color: context.colorScheme.surface) // after
/// ```
/// {@endtemplate}
extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);

  /// {@macro models.theme.ThemeGetter}
  ColorScheme get colorScheme => theme.colorScheme;
}
