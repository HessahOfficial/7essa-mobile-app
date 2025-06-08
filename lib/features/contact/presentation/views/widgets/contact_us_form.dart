import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class ContactUsForm extends StatelessWidget {
  final TextEditingController messageController;
  final GlobalKey<FormState> formKey;

  const ContactUsForm({
    super.key,
    required this.formKey,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextField(
            controller: messageController,
            inputColor: AppColors.white2,
            placeholder: S.of(context).messagePlaceholder,
            type: TextInputType.multiline,
            maxLines: 10,
            maxLength: 500,
            validator:
                (value) => Validator(
                  context: context,
                ).validateMessage(message: value!),
          ),
        ],
      ),
    );
  }
}
