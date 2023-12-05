import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/routes/go_routes_path.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/home_screen.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/introduction_screen.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/not_found_screen.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/play_ground.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/splash_screen.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/tab_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: GoRoutesPath.splash,
  errorBuilder: (final BuildContext context, final GoRouterState state) {
    return const NotFoundScreen();
  },
  routes: <RouteBase>[
    GoRoute(
      path: GoRoutesPath.splash,
      builder: (final BuildContext context, final GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: GoRoutesPath.introduction,
      builder: (final BuildContext context, final GoRouterState state) {
        return const IntroductionScreen();
      },
    ),
    GoRoute(
      path: GoRoutesPath.home,
      builder: (final BuildContext context, final GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: GoRoutesPath.tabScreen,
      builder: (final BuildContext context, final GoRouterState state) {
        return const TabScreen();
      },
    ),
    GoRoute(
      path: GoRoutesPath.playGround,
      builder: (final BuildContext context, final GoRouterState state) {
        return const PlayGround();
      },
    ),
  ],
);
