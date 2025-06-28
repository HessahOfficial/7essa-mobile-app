import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/generated/l10n.dart';

class ContactUsForm extends StatelessWidget {
  final TextEditingController messageController;
  final TextEditingController subjectController;
  final TextEditingController phoneController;

  final FocusNode messageFocusNode;
  final FocusNode subjectFocusNode;
  final FocusNode phoneFocusNode;

  final bool messageTouched;
  final bool subjectTouched;
  final bool phoneTouched;

  final GlobalKey<FormState> formKey;

  const ContactUsForm({
    super.key,
    required this.formKey,
    required this.messageController,
    required this.subjectController,
    required this.phoneController,
    required this.messageFocusNode,
    required this.subjectFocusNode,
    required this.phoneFocusNode,
    required this.messageTouched,
    required this.subjectTouched,
    required this.phoneTouched,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 15,
        children: [
          CustomTextField(
            fieldTocuhed: phoneTouched,
            focusNode: phoneFocusNode,
            controller: phoneController,
            icon: Icons.phone,
            inputColor: AppColors.white2,
            placeholder: S.of(context).phonePlaceholder,
            type: TextInputType.phone,
            validator: (value) {
              return Validator(context: context).validatePhone(phone: value!);
            },
          ),
          CustomTextField(
            fieldTocuhed: subjectTouched,
            focusNode: subjectFocusNode,
            controller: subjectController,
            icon: Icons.subject_rounded,
            iconSize: 20,
            inputColor: AppColors.white2,
            placeholder: S.of(context).subjectPlaceholder,
            type: TextInputType.text,
            validator: (value) {
              return Validator(
                context: context,
              ).validateSubject(subject: value!);
            },
          ),
          CustomTextField(
            fieldTocuhed: messageTouched,
            focusNode: messageFocusNode,
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
