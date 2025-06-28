import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/settings/presentation/managers/cloudinary_bloc.dart';
import 'package:hessa/features/wallet/data/models/get_payment_history_request.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_dropdown_menu.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payments_list.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_user_bar.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_wallet_card.dart';
import 'package:hessa/generated/l10n.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final menuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().hidden = true;
    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap:
                  () => setState(() {
                    context.read<WalletBloc>().hidden = true;
                    context.read<WalletBloc>().add(
                      GetPaymentHistoryEvent(
                        request: GetPaymentHistoryRequest(),
                      ),
                    );
                  }),
              splashColor: AppColors.gray.withOpacity(0.1),
              child: Container(
                padding: EdgeInsets.all(5),
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
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).wallet,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        listener: (bccontext, state) {
          if (state is CreatePaymentFailure) {
            showSnackBar(context: context, message: state.message, type: 1);
          } else if (state is CreatePaymentSuccess) {
            context.read<CloudinaryBloc>().image = null;
            showSnackBar(
              context: context,
              message: S.of(context).successfullPayment,
              type: 0,
            );
          } else if (state is GetPaymentHistoryFailure) {
            showSnackBar(context: context, message: state.message, type: 1);
          }
        },
        builder: (bccontext, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              spacing: 25,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomUserBar(screenContext: context),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomWalletCard(screenContext: context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).lastTransactions,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    CustomDropdownMenu(menuController: menuController),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   spacing: 20,
                //   children: [
                //     CustomButton(
                //       width: 100,
                //       height: 30,
                //       text: S.of(context).expenses,
                //       textColor:
                //           !isDark && expensesTapped
                //               ? AppColors.backgroundColorLight
                //               : null,
                //       backgroundColor:
                //           expensesTapped
                //               ? Theme.of(context).colorScheme.primary
                //               : AppColors.gray.withOpacity(0.1),
                //       onPressed:
                //           () =>
                //               context
                //                   .read<TransactionCubit>()
                //                   .loadExpensesList(),
                //     ),
                //     CustomButton(
                //       width: 100,
                //       height: 30,
                //       text: S.of(context).incomes,
                //       textColor:
                //           !isDark && !expensesTapped
                //               ? AppColors.backgroundColorLight
                //               : null,
                //       backgroundColor:
                //           !expensesTapped
                //               ? Theme.of(context).colorScheme.primary
                //               : AppColors.gray.withOpacity(0.3),
                //       onPressed:
                //           () =>
                //               context
                //                   .read<TransactionCubit>()
                //                   .loadIncomesList(),
                //     ),
                //   ],
                // ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomPaymentsList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
