import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';

class PaymentGatewayForm extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController screenshotController;

  final FocusNode amountFocusNode;
  final FocusNode screenshotFocusNode;

  final bool amountTouched;
  final bool screenshotTouched;

  final GlobalKey<FormState> formKey;

  const PaymentGatewayForm({
    super.key,
    required this.amountController,
    required this.screenshotController,
    required this.amountFocusNode,
    required this.screenshotFocusNode,
    required this.amountTouched,
    required this.screenshotTouched,
    required this.formKey,
  });

  @override
  State<PaymentGatewayForm> createState() => _PaymentGatewayFormState();
}

class _PaymentGatewayFormState extends State<PaymentGatewayForm> {
  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Form(
      key: widget.formKey,
      child: Column(
        spacing: 15,
        children: [
          RichText(
            text: TextSpan(
              text: "For payment gateways like (",
              children: [
                TextSpan(
                  text: "InstaPay",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ", "),
                TextSpan(
                  text: "Vodafone",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      ") transfer the money for the following number: 01016868492",
                ),
              ],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          CustomTextField(
            focusNode: widget.amountFocusNode,
            fieldTocuhed: widget.amountTouched,
            controller: widget.amountController,
            icon: FontAwesomeIcons.moneyBillTransfer,
            inputColor: AppColors.white2,
            placeholder: "Amount",
            type: TextInputType.number,
            validator: (value) {
              return Validator(context: context).validateAmount(amount: value!);
            },
          ),
          CustomTextField(
            focusNode: widget.screenshotFocusNode,
            fieldTocuhed: widget.screenshotTouched,
            controller: widget.screenshotController,
            icon: Icons.image,
            inputColor: AppColors.white2,
            placeholder: "Screenshot",
            type: TextInputType.url,
            suffixIcon: Icons.upload,
            suffixFunction: () {},
            validator: (value) {
              return Validator(
                context: context,
              ).validateUsername(username: value!);
            },
          ),
        ],
      ),
    );
  }
}
