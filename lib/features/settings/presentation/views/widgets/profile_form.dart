import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/validator.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';
import 'package:hessa/features/settings/presentation/managers/update_cubit.dart';
import 'package:hessa/generated/l10n.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController firstnameController;
  final TextEditingController lastnameController;
  final TextEditingController emailAddressController;
  final TextEditingController fullnameController;

  final FocusNode usernameFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode firstnameFocusNode;
  final FocusNode lastnameFocusNode;
  final FocusNode fullnameFocusNode;

  final bool usernameTouched;
  final bool phoneTouched;
  final bool firstnameTouched;
  final bool lastnameTouched;
  final bool fullnameTouched;

  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const ProfileForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.phoneController,
    required this.screenWidth,
    required this.firstnameController,
    required this.lastnameController,
    required this.usernameFocusNode,
    required this.phoneFocusNode,
    required this.firstnameFocusNode,
    required this.lastnameFocusNode,
    required this.usernameTouched,
    required this.phoneTouched,
    required this.firstnameTouched,
    required this.lastnameTouched,
    required this.emailAddressController,
    required this.fullnameController,
    required this.fullnameFocusNode,
    required this.fullnameTouched,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateCubit, UpdateState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isUpdate = context.read<UpdateCubit>().isUpdate;

        return Form(
          child: Column(
            spacing: 15,
            children: [
              CustomTextField(
                focusNode: firstnameFocusNode,
                fieldTocuhed: firstnameTouched,
                enabled: isUpdate,
                controller: firstnameController,
                icon: Icons.person,
                inputColor: AppColors.white2,
                placeholder: S.of(context).firstNamePLaceholder,
                type: TextInputType.name,
                validator: (value) {
                  return Validator(
                    context: context,
                  ).validateUsername(username: value!);
                },
              ),
              CustomTextField(
                enabled: isUpdate,
                focusNode: lastnameFocusNode,
                fieldTocuhed: lastnameTouched,
                controller: lastnameController,
                icon: Icons.person,
                inputColor: AppColors.white2,
                placeholder: S.of(context).lastNamePLaceholder,
                type: TextInputType.name,
                validator: (value) {
                  return Validator(
                    context: context,
                  ).validateUsername(username: value!);
                },
              ),
              CustomTextField(
                enabled: isUpdate,
                focusNode: fullnameFocusNode,
                fieldTocuhed: fullnameTouched,
                controller: fullnameController,
                icon: Icons.person,
                inputColor: AppColors.white2,
                placeholder: S.of(context).fullNamePLaceholder,
                type: TextInputType.name,
                validator: (value) {
                  return Validator(
                    context: context,
                  ).validateUsername(username: value!);
                },
              ),
              CustomTextField(
                fieldTocuhed: usernameTouched,
                focusNode: usernameFocusNode,
                enabled: isUpdate,
                controller: usernameController,
                icon: Icons.person,
                iconSize: 20,
                inputColor: AppColors.white2,
                placeholder: S.of(context).usernamePlaceholder,
                type: TextInputType.text,
                validator: (value) {
                  return Validator(
                    context: context,
                  ).validateUsername(username: value!);
                },
              ),
              CustomTextField(
                enabled: isUpdate,
                fieldTocuhed: phoneTouched,
                focusNode: phoneFocusNode,
                controller: phoneController,
                icon: Icons.phone,
                inputColor: AppColors.white2,
                placeholder: S.of(context).phonePlaceholder,
                type: TextInputType.phone,
                validator: (value) {
                  return Validator(
                    context: context,
                  ).validatePhone(phone: value!);
                },
              ),
              CustomTextField(
                enabled: false,
                controller: emailAddressController,
                icon: Icons.email_rounded,
                inputColor: AppColors.white2,
                placeholder: S.of(context).emailPlaceholder,
                type: TextInputType.emailAddress,
                validator: (value) {
                  return Validator(
                    context: context,
                  ).validateEmailAddress(email: value!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
