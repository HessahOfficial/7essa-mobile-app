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
import 'package:hessa/generated/l10n.dart';

class PaymentGatewayForm extends StatefulWidget {
  final TextEditingController amountController;
  final FocusNode amountFocusNode;
  final File? image;

  final bool amountTouched;

  final GlobalKey<FormState> formKey;

  const PaymentGatewayForm({
    super.key,
    required this.amountController,
    required this.amountFocusNode,
    required this.amountTouched,
    required this.formKey,
    this.image,
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
          Text(
            S.of(context).paymentFormTextPart1,

            style: TextStyle(
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: isDark ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
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
              return Validator(context: context).validateAmount(amount: value!);
            },
          ),
          BlocBuilder<CloudinaryBloc, CloudinaryState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image:
                          widget.image != null
                              ? DecorationImage(
                                image: FileImage(widget.image!),
                                fit: BoxFit.cover,
                              )
                              : null,
                      border: Border.all(
                        width: 1,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    child:
                        state is UploadImageLoading
                            ? SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            )
                            : (widget.image == null
                                ? Center(child: Icon(Icons.image))
                                : null),
                  ),
                  CustomButton(
                    onPressed:
                        () => context
                            .read<CloudinaryBloc>()
                            .showAvatarBottomSheet(context: context),
                    width: 120,
                    height: 50,
                    text: S.of(context).uploadBill,
                    textColor: Colors.white,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
