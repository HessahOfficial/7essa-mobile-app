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
  final TextEditingController emailAddressController;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const ProfileForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.phoneController,
    required this.emailAddressController,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateCubit, UpdateState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isUpdate = context.read<UpdateCubit>().isUpdate;

        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            spacing: 10,
            children: [
              CustomTextField(
                enabled: isUpdate,
                controller: usernameController,
                icon: Icons.person,
                iconSize: 20,
                iconColor: AppColors.blue800,
                inputColor: AppColors.white2,
                iconBackgroundColor: AppColors.blue100,
                placeholder: S.of(context).usernamePlaceholder,
                screenWidth: screenWidth,
                type: TextInputType.text,
                validator: (value) {
                  return Validator(
                    context: context,
                  ).validateUsername(username: value!);
                },
              ),
              CustomTextField(
                enabled: false,
                controller: phoneController,
                icon: Icons.phone,
                iconColor: AppColors.orange950,
                inputColor: AppColors.white2,
                iconBackgroundColor: AppColors.orange100,
                placeholder: S.of(context).phonePlaceholder,
                screenWidth: screenWidth,
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
                iconColor: AppColors.green800,
                inputColor: AppColors.white2,
                iconBackgroundColor: AppColors.green100,
                placeholder: S.of(context).emailPlaceholder,
                screenWidth: screenWidth,
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
