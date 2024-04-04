import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/core/router/route_list.dart';
import 'package:todo_application/feature/example/example_view.dart';
import 'package:todo_application/feature/home/home_view.dart';
import 'package:todo_application/feature/main/main_view.dart';

class Routes {
  static final Map<String, WidgetBuilder> _routes = {
    RouteList.main: (BuildContext context) => const MainView(),
    RouteList.home: (BuildContext context) => const HomeView(),
    RouteList.example: (BuildContext context) => const ExampleView(),
  };

  Map<String, WidgetBuilder> get allRoutes => _routes;

  static Route getRouteGenerate(RouteSettings settings) =>
      _routeGenerate(settings);

  static Route _routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.main:
        return _buildRoute(
          settings: settings,
          builder: const MainView(),
          fullScreenDialog: false,
        );

      case RouteList.home:
        return _buildRoute(
          settings: settings,
          builder: const HomeView(),
          fullScreenDialog: false,
        );

      case RouteList.example:
        return _buildRoute(
          settings: settings,
          builder: const ExampleView(),
          fullScreenDialog: false,
        );

      default:
        return MaterialPageRoute(
          builder: getRouteByName(settings.name!)!,
          maintainState: false,
          fullscreenDialog: true,
        );
    }
  }

  static WidgetBuilder? getRouteByName(String name) {
    if (_routes.containsKey(name) == false) {
      return _routes[RouteList.home];
    }
    return _routes[name];
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }

  /// T2 for view model
  /// T for class generic MaterialPageRoute

  static PageRoute _buildRoute<T, T2 extends Listenable?>({
    required RouteSettings settings,
    required Widget builder,
    viewModel,
    bool fullScreenDialog = false,
  }) {
    return MaterialPageRoute<T>(
      settings: settings,
      builder: (context) {
        if (null is! T2) {
          return ListenableProvider<T2>.value(
            value: viewModel,
            builder: (context, child) => builder,
          );
        } else {
          return builder;
        }
      },
      fullscreenDialog: fullScreenDialog,
    );
  }
}
