import 'package:flutter/material.dart';
import 'package:thc/views/login_register/login.dart';

/// {@template models.navigator}
/// We can make navigation a little cleaner with a global key and an extension type:
///
/// ```dart
/// // before
/// Navigator.of(context).push(
///   MaterialPageRoute(builder: (context) => const NewPage()),
/// );
///
/// // after
/// navigator.push(const NewPage());
/// ```
///
/// For times when you want to configure the page route,
/// you can still use `Navigator.of(context)`.
/// {@endtemplate}
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

/// {@macro models.navigator}
Nav get navigator => Nav(navKey.currentState!);

/// {@template models.navigator_example}
/// Example:
///
/// ```dart
/// void main() {
///   runApp(const App()); // "/"
/// }
///
/// navigator.push(const Screen1()); // "/Screen1"
///
/// navigator.push(const Screen2()); // "/Screen1/Screen2"
///
/// navigator.pushReplacement(const Replacement()); // "/Screen1/Replacement"
///
/// navigator.pop(); // "/Screen1"
///
/// navigator.pop(); // "/"
/// ```
/// {@endtemplate}
extension type Nav(NavigatorState navigator) {
  /// Adds a new screen to the route.
  ///
  /// {@macro models.navigator_example}
  Future<T?> push<T>(Widget destination) =>
      navigator.push<T>(MaterialPageRoute<T>(builder: (context) => destination));

  /// Adds a new screen in place of the current screen.
  ///
  /// {@macro models.navigator_example}
  Future<void> pushReplacement(Widget destination) => navigator.pushReplacement<void, void>(
        MaterialPageRoute<void>(builder: (context) => destination),
      );

  /// Removes the current screen from the route.
  ///
  /// {@macro models.navigator_example}
  void pop<T>([T? value]) => navigator.maybePop<T>(value);

  /// Creates a pop-up dialog.
  ///
  /// The [builder] should return an [AlertDialog] or something similar.
  Future<T?> showDialog<T>({required WidgetBuilder builder, bool? barrierDismissible}) {
    return showAdaptiveDialog<T>(
      context: navigator.context,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  void logout() {
    navigator.popUntil((_) => !navigator.canPop());
    pushReplacement(const LoginScreen());
  }
}