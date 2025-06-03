part of 'app_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: HomePage.routePath,
    routes: [
      GoRoute(
        path: HomePage.routePath,
        name: HomePage.routeName,
        builder: (context, state) => HomePage(),
        routes: [
          GoRoute(
            path: AddProductPage.routePath,
            name: AddProductPage.routeName,
            builder: (context, state) => AddProductPage(
              extra: state.extra as Map<String, dynamic>?,
            ),
          ),
          GoRoute(
            path: SearchProductPage.routePath,
            name: SearchProductPage.routeName,
            builder: (context, state) => SearchProductPage(),
          ),
          GoRoute(
            path: DeleteProductPage.routePath,
            name: DeleteProductPage.routeName,
            builder: (context, state) => DeleteProductPage(),
          )
        ],
      ),
    ],
  );
}
