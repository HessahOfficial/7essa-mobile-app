import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/wallet/data/models/get_payment_history_request.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class CustomDropdownMenu extends StatefulWidget {
  final TextEditingController menuController;

  const CustomDropdownMenu({super.key, required this.menuController});

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late String filter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    filter = S.of(context).all;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    return DropdownMenu<String>(
      width: 145,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        filled: true,
      ),
      textAlign: TextAlign.center,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
      initialSelection: S.of(context).all,
      hintText: S.of(context).all,
      menuStyle: MenuStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
      controller: widget.menuController,
      onSelected: (value) {
        if (value != null) {
          if (value == "all") {
            context.read<WalletBloc>().add(
              GetPaymentHistoryEvent(request: GetPaymentHistoryRequest()),
            );
          } else if (value == "deposit") {
            context.read<WalletBloc>().add(
              GetDepositHistoryEvent(request: GetPaymentHistoryRequest()),
            );
          } else if (value == "withdraw") {
            context.read<WalletBloc>().add(
              GetWithdrawHistoryEvent(request: GetPaymentHistoryRequest()),
            );
          }
        }
      },
      dropdownMenuEntries: [
        DropdownMenuEntry<String>(
          style: style,
          value: "all",
          label: S.of(context).all,
        ),
        DropdownMenuEntry<String>(
          style: style,
          value: "deposit",
          label: S.of(context).deposit,
        ),
        DropdownMenuEntry<String>(
          style: style,
          value: "withdraw",
          label: S.of(context).withdraw,
        ),
      ],
    );
  }
}
