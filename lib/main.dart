import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hessa/core/themes/dark_theme.dart';
import 'package:hessa/features/auth/data/models/token_model.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/home/data/repositories/property_service.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/main/presentation/managers/screen_cubit.dart';
import 'package:hessa/features/onboarding/presentation/managers/launch_cubit.dart';
import 'package:hessa/features/property/presentation/managers/location_cubit.dart';
import 'package:hessa/features/property/presentation/managers/slider_cubit.dart';
import 'package:hessa/features/settings/data/repositories/user_service.dart';
import 'package:hessa/features/settings/presentation/managers/image_cubit.dart';
import 'package:hessa/features/settings/presentation/managers/investor_cubit.dart';
import 'package:hessa/features/settings/presentation/managers/pin_cubit.dart';
import 'package:hessa/features/settings/presentation/managers/settings_cubit.dart';
import 'package:hessa/features/settings/presentation/managers/update_cubit.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';
import 'package:hessa/features/wallet/data/repositories/wallet_service.dart';
import 'package:hessa/features/wallet/presentation/managers/transaction_cubit.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hessa/generated/l10n.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/core/themes/light_theme.dart';
import 'package:hessa/core/utils/app_router.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/cubits/google/google_cubit.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/auth/data/repositories/auth_service.dart';
import 'package:hessa/firebase_options.dart';

void main() async {
  setupServices();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TokenModelAdapter());
  await getIt.get<HiveHelper>().initializeBoxes(); // Initialize Hive Boxes
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GoogleCubit>(create: (context) => GoogleCubit()),
        BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
        BlocProvider<TransactionCubit>(create: (context) => TransactionCubit()),
        BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()),
        BlocProvider<ScreenCubit>(create: (context) => ScreenCubit()),
        BlocProvider<ImageCubit>(create: (context) => ImageCubit()),
        BlocProvider<PinCubit>(create: (context) => PinCubit()),
        BlocProvider<UpdateCubit>(create: (context) => UpdateCubit()),
        BlocProvider<InvestorCubit>(create: (context) => InvestorCubit()),
        BlocProvider<LaunchCubit>(create: (context) => LaunchCubit()),
        BlocProvider<FavouriteCubit>(create: (context) => FavouriteCubit()),
        BlocProvider<SliderCubit>(create: (context) => SliderCubit()),
        BlocProvider<LocationCubit>(create: (context) => LocationCubit()),

        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(getIt.get<AuthService>()),
        ),
        BlocProvider<PropertyBloc>(
          create: (context) => PropertyBloc(getIt.get<PropertyService>()),
        ),
        BlocProvider<WalletBloc>(
          create: (context) => WalletBloc(service: getIt.get<WalletService>()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(service: getIt.get<UserService>()),
        ),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (bccontext, state) {
        return MaterialApp.router(
          locale: Locale(getIt.get<HiveHelper>().locale ?? "en"),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: AppRouter.router,
          title: 'Hessah|حصة',
          theme:
              getIt.get<HiveHelper>().isDark ?? false
                  ? getDarkThemeData()
                  : getLightThemeData(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
