import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class InvestorForm extends StatelessWidget {
  final TextEditingController nationalIdController;
  final FocusNode nationalIdFocusNode;
  final bool nationalIdTouched;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const InvestorForm({
    super.key,
    required this.nationalIdController,
    required this.screenWidth,
    required this.formKey,
    required this.nationalIdFocusNode,
    required this.nationalIdTouched,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              focusNode: nationalIdFocusNode,
              fieldTocuhed: nationalIdTouched,
              controller: nationalIdController,
              icon: FontAwesomeIcons.idCard,
              inputColor: AppColors.white2,
              placeholder: S.of(context).nationalIdPlaceholder,
              type: TextInputType.number,
              validator: (value) {
                return Validator(
                  context: context,
                ).validateNationalId(nationalId: value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
