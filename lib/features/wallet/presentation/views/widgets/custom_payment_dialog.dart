import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/settings/data/models/upload_image_request.dart';
import 'package:hessa/features/settings/presentation/managers/cloudinary_bloc.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';
import 'package:hessa/features/wallet/data/models/create_payment_request.dart';
import 'package:hessa/features/wallet/presentation/managers/wallet_bloc.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_payment_options_list.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/payment_gateway_form.dart';
import 'package:hessa/generated/l10n.dart';
import 'package:path/path.dart';

class CustomPaymentDialog extends StatefulWidget {
  final BuildContext screenContext;

  const CustomPaymentDialog({super.key, required this.screenContext});

  @override
  State<CustomPaymentDialog> createState() => _CustomPaymentDialogState();
}

class _CustomPaymentDialogState extends State<CustomPaymentDialog> {
  final amountController = TextEditingController();

  final amountFocusNode = FocusNode();

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
  }

  @override
  void dispose() {
    amountController.dispose();
    amountFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

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
                  PaymentGatewayForm(
                    amountController: amountController,
                    amountFocusNode: amountFocusNode,
                    image: image,
                    amountTouched: amountTouched,
                    formKey: formKey,
                  ),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
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
                                amount: double.parse(amountController.text),
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
                      }
                    },
                    width: 100,
                    height: 40,
                    text: S.of(context).deposit,
                    textColor: Colors.white,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
