import 'package:go_router/go_router.dart';

import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/utils/type_aliases.dart';
import 'package:hessa/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:hessa/features/auth/presentation/views/login_screen.dart';
import 'package:hessa/features/auth/presentation/views/register_screen.dart';
import 'package:hessa/features/main/presentation/views/main_screen.dart';
import 'package:hessa/features/notification/presentation/views/notifications_screen.dart';
import 'package:hessa/features/property/presentation/views/gallery_screen.dart';
import 'package:hessa/features/property/presentation/views/property_screen.dart';
import 'package:hessa/features/settings/presentation/views/become_investor_screen.dart';
import 'package:hessa/features/contact/presentation/views/contact_us_screen.dart';
import 'package:hessa/features/settings/presentation/views/privacy_policy_screen.dart';
import 'package:hessa/features/settings/presentation/views/profile_screen.dart';
import 'package:hessa/features/onboarding/presentation/views/onboarding_screen.dart';
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
        path: AppRoutes.mainView,
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileView,
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.becomeInvestorView,
        builder: (context, state) => BecomeInvestorScreen(),
      ),
      GoRoute(
        path: AppRoutes.contactUsView,
        builder: (context, state) => ContactUsScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationsView,
        builder: (context, state) => NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.policyPrivacyView,
        builder: (context, state) => PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppRoutes.propertyView,
        builder: (context, state) {
          final params = state.extra as Json;
          return PropertyScreen(property: params["property"]);
        },
      ),
      GoRoute(
        path: AppRoutes.galleryView,
        builder: (context, state) {
          final params = state.extra as Json;
          return GalleryScreen(
            images: params["images"],
            initialIndex: params["init"],
          );
        },
      ),
    ],
  );
}
