import 'package:flutter/widgets.dart';

/// Hosts [home] in a [Navigator] with a [MediaQuery] from the test view, like
/// `MaterialApp(home: ...)`, without depending on the Material library.
class TestApp extends StatelessWidget {
  const TestApp({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFF000000),
      pageRouteBuilder:
          <T>(RouteSettings settings, WidgetBuilder builder) =>
              PageRouteBuilder<T>(
                settings: settings,
                pageBuilder: (context, _, _) => builder(context),
              ),
      home: home,
    );
  }
}
