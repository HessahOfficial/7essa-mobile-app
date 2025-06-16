import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';

import 'package:hessa/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_category_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/category_tabs_list.dart';
import 'package:hessa/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  final TextEditingController searchController = TextEditingController();
  final BuildContext screenContext;

  HomeScreen({super.key, required this.screenContext});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            CustomAppBar(screenContext: context),
            CategoryTabsList(),
            Expanded(child: CustomCategoryList(screenContext: context)),
          ],
        ),
      ),
    );
  }
}
