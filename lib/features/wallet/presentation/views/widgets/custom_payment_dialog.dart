import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payment_option.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payment_options_list.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/payment_gateway_form.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPaymentDialog extends StatefulWidget {
  final BuildContext screenContext;

  const CustomPaymentDialog({super.key, required this.screenContext});

  @override
  State<CustomPaymentDialog> createState() => _CustomPaymentDialogState();
}

class _CustomPaymentDialogState extends State<CustomPaymentDialog> {
  final amountController = TextEditingController();
  final screenshotController = TextEditingController();

  final amountFocusNode = FocusNode();
  final screenshotFocusNode = FocusNode();

  bool amountTouched = false;
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

    screenshotFocusNode.addListener(() {
      if (screenshotFocusNode.hasFocus) {
        setState(() {
          screenshotTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    screenshotController.dispose();

    amountFocusNode.dispose();
    screenshotFocusNode.dispose();

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
          child: Column(
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
              CustomPaymentOptionsList(),
              PaymentGatewayForm(
                amountController: amountController,
                screenshotController: screenshotController,
                amountFocusNode: amountFocusNode,
                screenshotFocusNode: screenshotFocusNode,
                amountTouched: amountTouched,
                screenshotTouched: screenshotTouched,
                formKey: formKey,
              ),
              CustomButton(
                width: 100,
                height: 40,
                text: S.of(context).deposit,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
