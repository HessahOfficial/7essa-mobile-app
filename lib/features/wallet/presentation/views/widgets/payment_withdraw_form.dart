import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/features/settings/presentation/managers/cloudinary_bloc.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class PaymentWithdrawForm extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController phoneController;
  final TextEditingController creditController;
  final TextEditingController instapayController;

  final FocusNode amountFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode creditFocusNode;
  final FocusNode instapayFocusNode;

  final bool amountTouched;
  final bool phoneTouched;
  final bool creditTouched;
  final bool instapayTouched;

  final int option;

  final GlobalKey<FormState> formKey;

  const PaymentWithdrawForm({
    super.key,
    required this.amountController,
    required this.amountFocusNode,
    required this.amountTouched,
    required this.formKey,
    required this.phoneController,
    required this.phoneFocusNode,
    required this.phoneTouched,
    required this.option,
    required this.creditController,
    required this.creditFocusNode,
    required this.creditTouched,
    required this.instapayController,
    required this.instapayFocusNode,
    required this.instapayTouched,
  });

  @override
  State<PaymentWithdrawForm> createState() => _PaymentWithdrawFormState();
}

class _PaymentWithdrawFormState extends State<PaymentWithdrawForm> {
  @override
  Widget build(BuildContext context) {

    return Form(
      key: widget.formKey,
      child: Column(
        spacing: 15,
        children: [
          if (widget.option == 2)
            CustomTextField(
              fieldTocuhed: widget.creditTouched,
              focusNode: widget.creditFocusNode,
              controller: widget.creditController,
              icon: Icons.credit_card_rounded,
              inputColor: AppColors.white2,
              placeholder: S.of(context).creditPlaceholder,
              type: TextInputType.number,
              validator: (value) {
                return Validator(
                  context: context,
                ).validateCreditCard(credit: value!);
              },
            ),
          if (widget.option == 1)
            CustomTextField(
              fieldTocuhed: widget.phoneTouched,
              focusNode: widget.phoneFocusNode,
              controller: widget.phoneController,
              icon: Icons.phone,
              inputColor: AppColors.white2,
              placeholder: S.of(context).phonePlaceholder,
              type: TextInputType.phone,
              validator: (value) {
                return Validator(
                  context: context,
                ).validateVodafoneNumber(phone: value!);
              },
            ),
          if (widget.option == 0)
            CustomTextField(
              fieldTocuhed: widget.instapayTouched,
              focusNode: widget.instapayFocusNode,
              controller: widget.instapayController,
              icon: Icons.alternate_email_rounded,
              inputColor: AppColors.white2,
              placeholder: S.of(context).instapayPlaceholder,
              type: TextInputType.emailAddress,
              validator: (value) {
                return Validator(
                  context: context,
                ).validateInstapay(instapay: value!);
              },
            ),
          CustomTextField(
            focusNode: widget.amountFocusNode,
            fieldTocuhed: widget.amountTouched,
            controller: widget.amountController,
            icon: FontAwesomeIcons.moneyBillTransfer,
            inputColor: AppColors.white2,
            placeholder: S.of(context).amountPlaceholder,
            type: TextInputType.number,
            validator: (value) {
              return Validator(
                context: context,
              ).validateAmount(amount: value!, paymentType: "withdraw");
            },
          ),
        ],
      ),
    );
  }
}
