import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nagarifrontline/pages/print/views/print.dart';
import 'package:nagarifrontline/pages/login/views/login.dart';

import 'pages/home/views/home.dart';
import 'pages/queue/views/queue.dart';

GoRouter routerApp() {
  return GoRouter(
    initialLocation: HomePage.path,
    routes: <RouteBase>[
      GoRoute(
        path: LoginPage.path,
        name: LoginPage.name,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: PrintPage.path,
        name: PrintPage.name,
        builder: (BuildContext context, GoRouterState state) {
          return const PrintPage();
        },
      ),
      GoRoute(
        path: HomePage.path,
        name: HomePage.name,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: QueuePage.path,
        name: QueuePage.name,
        builder: (BuildContext context, GoRouterState state) {
          return const QueuePage();
        },
      ),
    ],
  );
}
