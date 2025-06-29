import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_request.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/data/models/investment_query_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';
import 'package:hessa/features/investment/presentation/views/widgets/custom_investments_list.dart';
import 'package:hessa/features/investment/presentation/views/widgets/custom_pie_chart.dart';
import 'package:hessa/generated/l10n.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    final currentUser = getIt.get<HiveHelper>().currentUser;
    context.read<InvestmentBloc>().add(
      GetAllInvestmentsEvent(
        request: GetAllInvestmentsRequest(
          query: InvestmentQueryModel(userId: currentUser!.id!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [
          InkWell(
            onTap: () {
              final currentUser = getIt.get<HiveHelper>().currentUser;
              context.read<InvestmentBloc>().add(
                GetAllInvestmentsEvent(
                  request: GetAllInvestmentsRequest(
                    query: InvestmentQueryModel(userId: currentUser!.id!),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(50),
            splashColor: AppColors.gray.withOpacity(0.1),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.refresh,
                size: 25,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).myInvestments,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (bccontext, state) {
          if (state is RefreshTokenFailure) {
            context.go(AppRoutes.loginView);
          }
        },
        builder: (bccontext, state) {
          return BlocConsumer<InvestmentBloc, InvestmentState>(
            listener: (bccontext, state) {
              if (state is GetAllInvestmentsFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              }
            },
            builder: (bccontext, state) {
              bool isDark = getIt.get<HiveHelper>().isDark ?? false;
              int selectedIndex = context.read<InvestmentBloc>().selectedIndex;
              List<InvestmentModel> investments =
                  context.read<InvestmentBloc>().investments;

              return state is GetAllInvestmentsLoading
                  ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        color:
                            isDark
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                  : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child:
                        investments.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).emptyInvetsments,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                            : Column(
                              spacing: 25,
                              children: [
                                CustomPieChart(
                                  currentInvestment: investments[selectedIndex],
                                ),
                                Text(
                                  investments[selectedIndex].propertyId!.title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                CustomInvestmentsList(investments: investments),
                              ],
                            ),
                  );
            },
          );
        },
      ),
    );
  }
}
