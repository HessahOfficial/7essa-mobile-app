import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hessa/features/home/presentation/views/home_screen.dart';
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
      Container(child: Center(child: Text("Favourites"))),
      WalletScreen(),
      SettingsScreen(),
      Container(child: Center(child: Text("Investment"))),
    ];

    return BlocBuilder<ScreenCubit, ScreenState>(
      builder: (bccontext, state) {
        int index = context.read<ScreenCubit>().currentIndex;

        return Scaffold(
          body: screens[index],
          bottomNavigationBar: Container(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
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
                                () => context
                                    .read<ScreenCubit>()
                                    .setCurrentIndex(index: 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: CustomNavItem(
                            icon: Icons.wallet_rounded,
                            index: 2,
                            selectedIndex: index,
                            onTap:
                                () => context
                                    .read<ScreenCubit>()
                                    .setCurrentIndex(index: 2),
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
                InkWell(
                  borderRadius: BorderRadius.circular(25),
                  splashColor: Theme.of(context).colorScheme.secondary,
                  onTap:
                      () =>
                          context.read<ScreenCubit>().setCurrentIndex(index: 4),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(1, 1),
                          ),
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(-1, -1),
                          ),
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(-1, 1),
                          ),
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(1, -1),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 25,
                        child: Icon(Icons.pie_chart, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
