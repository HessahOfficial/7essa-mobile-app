import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/features/wallet/presentation/managers/balance_cubit.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_wallet_button.dart';
import 'package:hessa/generated/l10n.dart';

class CustomWalletCard extends StatelessWidget {
  const CustomWalletCard({super.key, required this.screenContext});

  final BuildContext screenContext;

  final _balance = 2025.26;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BalanceCubit, BalanceState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool hide = context.read<BalanceCubit>().hide;

        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.24)),
          height: 187,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: SvgPicture.asset("assets/images/wallet.svg"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).currentBalance,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          hide ? "*******" : _balance.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        InkWell(
                          onTap:
                              () =>
                                  hide
                                      ? context
                                          .read<BalanceCubit>()
                                          .showBalance(screenContext)
                                      : context
                                          .read<BalanceCubit>()
                                          .balanceVisibility(),
                          splashColor: Colors.transparent,
                          child: Icon(
                            hide ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomWalletButton(
                          title: S.of(context).deposit,
                          icon: Icons.add_box,
                        ),
                        CustomWalletButton(
                          title: S.of(context).withdraw,
                          icon: FontAwesomeIcons.moneyBill,
                          spacing: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
