import 'package:go_router/go_router.dart';

import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:hessa/features/auth/presentation/views/login_screen.dart';
import 'package:hessa/features/auth/presentation/views/otp-screen.dart';
import 'package:hessa/features/auth/presentation/views/register_screen.dart';
import 'package:hessa/features/main/presentation/views/main_screen.dart';
import 'package:hessa/onboarding_screen.dart';
import 'package:hessa/splash_screen.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.splashView,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onBoardingView,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.registerView,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginView,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordView,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpView,
        builder: (context, state) {
          final params = state.extra as Json;
          return OtpScreen(emailAddress: params["emailAddress"]);
        },
      ),
      GoRoute(
        path: AppRoutes.mainView,
        builder: (context, state) => MainScreen(),
      ),
    ],
  );
}
