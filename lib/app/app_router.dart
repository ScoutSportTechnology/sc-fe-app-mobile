import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const _Placeholder('Home'));
      case AppRoutes.stream:
        return MaterialPageRoute(builder: (_) => const _Placeholder('Stream'));
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const _Placeholder('Settings'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const _Placeholder('Not found'),
        );
    }
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(child: Text('$label page')),
    );
  }
}
