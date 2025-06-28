import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/wallet/data/models/get_payment_history_request.dart';
import 'package:hessa/features/wallet/data/models/payment_model.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payment_item.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPaymentsList extends StatefulWidget {
  const CustomPaymentsList({super.key});

  @override
  State<CustomPaymentsList> createState() => _CustomPaymentsListState();
}

class _CustomPaymentsListState extends State<CustomPaymentsList> {
  @override
  void initState() {
    super.initState();

    context.read<WalletBloc>().add(
      GetPaymentHistoryEvent(request: GetPaymentHistoryRequest()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (bccontext, state) {
        bool isDark = getIt.get<HiveHelper>().isDark ?? false;
        List<PaymentModel> payments = context.read<WalletBloc>().payments;

        return state is GetPaymentHistoryLoading ||
                state is GetDepositHistoryLoading ||
                state is GetWithdrawHistoryLoading
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
            : (payments.isEmpty
                ? Text(
                  S.of(context).noTransactionsYet,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )
                : ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: payments.length,
                  itemBuilder:
                      (context, index) =>
                          CustomPaymentItem(payment: payments[index]),
                ));
      },
    );
  }
}
