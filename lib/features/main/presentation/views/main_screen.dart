import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hessa/features/favourite/presentation/views/saves_screen.dart';
import 'package:hessa/features/home/presentation/views/home_screen.dart';
import 'package:hessa/features/investment/presentation/views/investment_screen.dart';
import 'package:hessa/features/main/presentation/managers/screen_cubit.dart';
import 'package:hessa/features/main/presentation/views/widgets/custom_nav_item.dart';
import 'package:hessa/features/settings/presentation/views/settings_screen.dart';
import 'package:hessa/features/wallet/presentation/views/wallet_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(screenContext: context),
      SaveedPropertiesScreen(),
      WalletScreen(),
      SettingsScreen(),
      InvestmentScreen(),
    ];

    return BlocBuilder<ScreenCubit, ScreenState>(
      builder: (bccontext, state) {
        int index = context.read<ScreenCubit>().currentIndex;

        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Icon(
                FontAwesomeIcons.chartPie,
                color: Colors.white,
                size: 30,
              ),
            ),
            onPressed: () {
              context.read<ScreenCubit>().setCurrentIndex(index: 4);
            },
          ),
          body: screens[index],
          bottomNavigationBar: Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              height: 70,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    CustomNavItem(
                      icon: Icons.home_rounded,
                      index: 0,
                      selectedIndex: index,
                      onTap:
                          () => context.read<ScreenCubit>().setCurrentIndex(
                            index: 0,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: CustomNavItem(
                        icon: Icons.bookmark_outlined,
                        index: 1,
                        selectedIndex: index,
                        onTap:
                            () => context.read<ScreenCubit>().setCurrentIndex(
                              index: 1,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: CustomNavItem(
                        icon: Icons.wallet_rounded,
                        index: 2,
                        selectedIndex: index,
                        onTap:
                            () => context.read<ScreenCubit>().setCurrentIndex(
                              index: 2,
                            ),
                      ),
                    ),
                    CustomNavItem(
                      icon: Icons.settings_rounded,
                      index: 3,
                      selectedIndex: index,
                      onTap:
                          () => context.read<ScreenCubit>().setCurrentIndex(
                            index: 3,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
