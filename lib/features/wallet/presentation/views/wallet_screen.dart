import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/wallet/presentation/managers/balance_cubit.dart';
import 'package:hessa/features/wallet/presentation/managers/transaction_cubit.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_transaction_list.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_user_bar.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_wallet_card.dart';
import 'package:hessa/generated/l10n.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocConsumer<BalanceCubit, BalanceState>(
      listener: (context, state) {
        if (state is BalanceFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              actionsPadding: EdgeInsets.symmetric(horizontal: 20),
              actions: [InkWell(child: Icon(Icons.refresh, size: 25))],
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                S.of(context).wallet,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: BlocConsumer<TransactionCubit, TransactionState>(
              listener: (context, state) {
                if (state is TransactionFailure) {
                  print("Error: ${state.message}");
                }
              },
              builder: (bccontext, state) {
                bool expensesTapped =
                    context.read<TransactionCubit>().expensesTapped;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    spacing: 25,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomUserBar(),
                      CustomWalletCard(screenContext: context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          CustomButton(
                            width: 100,
                            height: 30,
                            text: S.of(context).expenses,
                            textColor:
                                !isDark && expensesTapped
                                    ? AppColors.backgroundColorLight
                                    : null,
                            backgroundColor:
                                expensesTapped
                                    ? Theme.of(context).colorScheme.primary
                                    : AppColors.gray.withOpacity(0.1),
                            onPressed:
                                () =>
                                    context
                                        .read<TransactionCubit>()
                                        .loadExpensesList(),
                          ),
                          CustomButton(
                            width: 100,
                            height: 30,
                            text: S.of(context).incomes,
                            textColor:
                                !isDark && !expensesTapped
                                    ? AppColors.backgroundColorLight
                                    : null,
                            backgroundColor:
                                !expensesTapped
                                    ? Theme.of(context).colorScheme.primary
                                    : AppColors.gray.withOpacity(0.3),
                            onPressed:
                                () =>
                                    context
                                        .read<TransactionCubit>()
                                        .loadIncomesList(),
                          ),
                        ],
                      ),
                      CustomTransactionList(
                        transactions:
                            context.read<TransactionCubit>().transactionList,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
