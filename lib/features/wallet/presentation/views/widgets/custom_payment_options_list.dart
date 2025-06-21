import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payment_option.dart';

class CustomPaymentOptionsList extends StatelessWidget {
  const CustomPaymentOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (bccontext, state) {
        int selectedIndex = context.read<WalletBloc>().selectedPaymentOption;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomPaymentOption(
              index: 0,
              borderRadius: BorderRadius.circular(10),
              selectedIndex: selectedIndex,
              image: "assets/images/InstaPay_Logo.png",
              onTap:
                  () => context.read<WalletBloc>().setSelectedPaymentOption(0),
            ),
            CustomPaymentOption(
              borderRadius: BorderRadius.circular(10),
              index: 1,
              selectedIndex: selectedIndex,
              image: "assets/images/vodafone-logo_brandlogos.net_9etir.png",
              onTap:
                  () => context.read<WalletBloc>().setSelectedPaymentOption(1),
            ),
            CustomPaymentOption(
              borderRadius: BorderRadius.circular(10),
              index: 2,
              selectedIndex: selectedIndex,
              icon: FontAwesomeIcons.buildingColumns,
              textIcon: "Bank",
              onTap:
                  () => context.read<WalletBloc>().setSelectedPaymentOption(2),
            ),
          ],
        );
      },
    );
  }
}
