import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';

class InvestorForm extends StatelessWidget {
  final TextEditingController fullnameController;
  final TextEditingController nationalIdController;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const InvestorForm({
    super.key,
    required this.fullnameController,
    required this.nationalIdController,
    required this.screenWidth,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextField(
            controller: fullnameController,
            icon: Icons.person,
            iconSize: 20,
            iconColor: AppColors.blue800,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.blue100,
            placeholder: "Fullname",
            screenWidth: screenWidth,
            type: TextInputType.text,
            validator: (value) {
              return Validator(
                context: context,
              ).validateFullname(fullname: value!);
            },
          ),
          SizedBox(height: 15),
          CustomTextField(
            controller: nationalIdController,
            icon: FontAwesomeIcons.idCard,
            iconColor: AppColors.orange950,
            inputColor: AppColors.white2,
            iconBackgroundColor: AppColors.orange100,
            placeholder: "National ID",
            screenWidth: screenWidth,
            type: TextInputType.number,
            validator: (value) {
              return Validator(
                context: context,
              ).validateNationalId(nationalId: value!);
            },
          ),
        ],
      ),
    );
  }
}
