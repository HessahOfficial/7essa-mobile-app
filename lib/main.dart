import 'package:flutter/material.dart';
import 'package:hessa/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:hessa/screens/wallet-page.dart';
import 'package:provider/provider.dart';
import 'saved_properties_provider.dart';
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SavedPropertiesProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: "SF-Mono"
        ),
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: SplashScreen()
    );
  }
}


