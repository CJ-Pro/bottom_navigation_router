import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;

  const BottomNavigator({
    Key? key,
    required this.navigatorKey,
    required this.onGenerateRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
