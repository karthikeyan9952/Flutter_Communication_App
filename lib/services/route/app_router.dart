import 'package:go_router/go_router.dart';
import 'package:realtime_communication_app/features/calls/presentation/screens/calls_screen.dart';
import 'package:realtime_communication_app/features/chats/presentation/screens/chats_screen.dart';
import 'package:realtime_communication_app/features/login/presentaion/screens/login_screen.dart';
import 'package:realtime_communication_app/features/login/presentaion/screens/login_verification_screen.dart';
import 'package:realtime_communication_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:realtime_communication_app/features/splash/splash.dart';
import 'package:realtime_communication_app/services/route/app_routes.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Splash(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.loginVerification,
      builder: (context, state) => const LoginVerficationScreen(),
    ),
    GoRoute(
      path: AppRoutes.chats,
      builder: (context, state) => const ChatsScreen(),
    ),
    GoRoute(
      path: AppRoutes.calls,
      builder: (context, state) => const CallsScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
