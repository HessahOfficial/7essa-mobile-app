import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/settings/presentation/managers/image_cubit.dart';
import 'package:hessa/features/settings/presentation/managers/pin_cubit.dart';
import 'package:hessa/features/settings/presentation/views/widgets/change_pin_item.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_avatar.dart';
import 'package:hessa/features/settings/presentation/views/widgets/edit_profile_item.dart';
import 'package:hessa/features/settings/presentation/views/widgets/profile_form.dart';
import 'package:hessa/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;
    usernameController.text = currentUser.username!;
    emailAddressController.text = currentUser.email!;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: AppColors.gray.withOpacity(0.01),
          borderRadius: BorderRadius.circular(100),
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          S.of(context).personalProfile,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ImageCubit, ImageState>(
        builder: (bccontext, state) {
          File? image = context.read<ImageCubit>().image;
          bool isInvestor =
              getIt.get<HiveHelper>().currentUser!.isInvestor ?? false;

          return BlocConsumer<PinCubit, PinState>(
            listener: (bccontext, state) {
              if (state is PinFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              } else if (state is PinSuccess) {
                showSnackBar(
                  context: context,
                  message: S.of(context).pinDialog,
                  type: 0,
                );
              }
            },
            builder: (bccontext, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  spacing: 30,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CustomAvatar(image: image),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: AppColors.gray.withOpacity(0.1),
                          onTap:
                              () => context
                                  .read<ImageCubit>()
                                  .showAvatarBottomSheet(context: context),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ProfileForm(
                      formKey: formKey,
                      usernameController: usernameController,
                      phoneController: phoneController,
                      emailAddressController: emailAddressController,
                      screenWidth: screenWidth,
                    ),
                    ChangePinItem(screenContext: context),
                    EditProfileItem(),
                    isInvestor
                        ? Container()
                        : GestureDetector(
                          onTap:
                              () => context.push(AppRoutes.becomeInvestorView),
                          child: Text(
                            S.of(context).becomeInvestorWithUs,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          FontAwesomeIcons.fileArrowDown,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
