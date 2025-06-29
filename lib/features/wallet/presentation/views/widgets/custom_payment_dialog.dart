import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/settings/presentation/managers/cloudinary_bloc.dart';
import 'package:hessa/features/wallet/data/models/create_payment_request.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payment_options_list.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/payment_deposit_form.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/payment_withdraw_form.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPaymentDialog extends StatefulWidget {
  final BuildContext screenContext;
  final bool isDeposit;

  const CustomPaymentDialog({
    super.key,
    required this.screenContext,
    required this.isDeposit,
  });

  @override
  State<CustomPaymentDialog> createState() => _CustomPaymentDialogState();
}

class _CustomPaymentDialogState extends State<CustomPaymentDialog> {
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  final creditController = TextEditingController();
  final instapayController = TextEditingController();

  final amountFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final creditFocusNode = FocusNode();
  final instapayFocusNode = FocusNode();

  bool amountTouched = false;
  bool phoneTouched = false;
  bool creditTouched = false;
  bool instapayTouched = false;
  bool screenshotTouched = false;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();

    amountFocusNode.addListener(() {
      if (amountFocusNode.hasFocus) {
        setState(() {
          amountTouched = true;
        });
      }
    });

    phoneFocusNode.addListener(() {
      if (phoneFocusNode.hasFocus) {
        setState(() {
          phoneTouched = true;
        });
      }
    });

    creditFocusNode.addListener(() {
      if (creditFocusNode.hasFocus) {
        setState(() {
          creditTouched = true;
        });
      }
    });

    instapayFocusNode.addListener(() {
      if (instapayFocusNode.hasFocus) {
        setState(() {
          instapayTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    phoneController.dispose();
    creditController.dispose();
    instapayController.dispose();

    amountFocusNode.dispose();
    phoneFocusNode.dispose();
    creditFocusNode.dispose();
    instapayFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: screenWidth * 0.06,
          ),
          physics: BouncingScrollPhysics(),
          child: BlocBuilder<CloudinaryBloc, CloudinaryState>(
            builder: (bccontext, state) {
              File? image = context.read<CloudinaryBloc>().image;

              return BlocBuilder<WalletBloc, WalletState>(
                builder: (bccontext, state) {
                  int option = context.read<WalletBloc>().selectedPaymentOption;
                  return Column(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.gray,
                        ),
                        width: 50,
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: CustomPaymentOptionsList(),
                      ),
                      widget.isDeposit
                          ? PaymentDepositForm(
                            amountController: amountController,
                            amountFocusNode: amountFocusNode,
                            image: image,
                            amountTouched: amountTouched,
                            formKey: formKey,
                          )
                          : PaymentWithdrawForm(
                            option: option,
                            amountController: amountController,
                            amountFocusNode: amountFocusNode,
                            amountTouched: amountTouched,
                            formKey: formKey,
                            phoneController: phoneController,
                            phoneFocusNode: phoneFocusNode,
                            phoneTouched: phoneTouched,
                            creditController: creditController,
                            creditFocusNode: creditFocusNode,
                            creditTouched: creditTouched,
                            instapayController: instapayController,
                            instapayFocusNode: instapayFocusNode,
                            instapayTouched: instapayTouched,
                          ),
                      CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (widget.isDeposit) {
                              if (image == null) {
                                showSnackBar(
                                  context: context,
                                  message: S.of(context).uploadBillMessage,
                                  type: 1,
                                );
                              } else {
                                context.read<WalletBloc>().add(
                                  CreatePaymentEvent(
                                    request: CreatePaymentRequest(
                                      amount: double.parse(
                                        amountController.text,
                                      ),
                                      paymentMethod:
                                          context
                                              .read<WalletBloc>()
                                              .selectedPaymentMethod,
                                      screenshot: image,
                                      paymentType: "deposit",
                                    ),
                                  ),
                                );
                                context.pop();
                              }
                            } else {
                              context.read<WalletBloc>().add(
                                CreatePaymentEvent(
                                  request: CreatePaymentRequest(
                                    amount: double.parse(amountController.text),
                                    paymentMethod:
                                        context
                                            .read<WalletBloc>()
                                            .selectedPaymentMethod,
                                    screenshot: null,
                                    paymentType: "withdraw",
                                  ),
                                ),
                              );
                              context.pop();
                            }
                          }
                        },
                        width: 100,
                        height: 40,
                        text:
                            widget.isDeposit
                                ? S.of(context).deposit
                                : S.of(context).withdraw,
                        textColor: Colors.white,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
