import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/settings/data/models/update_user_request.dart';
import 'package:hessa/features/settings/data/models/upload_image_request.dart';
import 'package:hessa/features/settings/presentation/managers/cloudinary_bloc.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';
import 'package:hessa/features/settings/presentation/views/widgets/become_investor_button.dart';
import 'package:hessa/features/settings/presentation/views/widgets/change_pin_item.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_avatar.dart';
import 'package:hessa/features/settings/presentation/views/widgets/edit_profile_item.dart';
import 'package:hessa/features/settings/presentation/views/widgets/profile_form.dart';
import 'package:hessa/generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final usernameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final fullnameController = TextEditingController();

  final firstnameFocusNode = FocusNode();
  final lastnameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final fullnameFocusNode = FocusNode();

  bool firstnameTouched = false;
  bool lastnameTouched = false;
  bool usernameTouched = false;
  bool phoneTouched = false;
  bool fullnameTouched = false;

  late GlobalKey<FormState> formKey;

  UserModel currentUser = UserModel();

  @override
  void initState() {
    super.initState();
    currentUser = getIt.get<HiveHelper>().currentUser!;
    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    formKey = GlobalKey<FormState>();

    firstnameController.text = currentUser.firstName ?? "";
    lastnameController.text = currentUser.lastName ?? "";
    fullnameController.text = currentUser.fullName ?? "";
    usernameController.text = currentUser.username ?? "";
    emailAddressController.text = currentUser.email ?? "";
    phoneController.text = currentUser.phoneNumber ?? "";

    firstnameFocusNode.addListener(() {
      if (firstnameFocusNode.hasFocus) {
        setState(() {
          firstnameTouched = true;
        });
      }
    });

    lastnameFocusNode.addListener(() {
      if (lastnameFocusNode.hasFocus) {
        setState(() {
          lastnameTouched = true;
        });
      }
    });

    usernameFocusNode.addListener(() {
      if (usernameFocusNode.hasFocus) {
        setState(() {
          usernameTouched = true;
        });
      }
    });

    phoneFocusNode.addListener(() {
      if (phoneFocusNode.hasFocus) {
        setState(() {
          phoneTouched = true;
        });
      }
    });

    fullnameFocusNode.addListener(() {
      if (fullnameFocusNode.hasFocus) {
        setState(() {
          fullnameTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    fullnameController.dispose();

    firstnameFocusNode.dispose();
    lastnameFocusNode.dispose();
    usernameFocusNode.dispose();
    phoneFocusNode.dispose();
    fullnameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

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
      body: BlocConsumer<CloudinaryBloc, CloudinaryState>(
        listener: (bccontext, state) {
          if (state is ChangeImage) {
            context.read<CloudinaryBloc>().add(
              UplodImageEvent(
                request: UploadImageRequest(
                  imageFile: context.read<CloudinaryBloc>().image!,
                ),
              ),
            );
          } else if (state is UploadImageFailure) {
            showSnackBar(context: context, message: state.message, type: 1);
          } else if (state is UploadImageSuccess) {
            context.read<UserBloc>().add(
              UpdateAvatarEvent(
                request: UpdateUserRequest(avatar: state.response.image_url),
              ),
            );
          }
        },
        builder: (bccontext, state) {
          bool isInvestor =
              getIt.get<HiveHelper>().currentUser!.isInvestor ?? false;

          return BlocConsumer<UserBloc, UserState>(
            listener: (bccontext, state) {
              if (state is ChangePinFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              } else if (state is ChangePinSuccess) {
                showSnackBar(
                  context: context,
                  message: S.of(context).pinDialog,
                  type: 0,
                );
              } else if (state is UpdateAvatarFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              } else if (state is UpdateAvatarSuccess) {
                showSnackBar(
                  context: context,
                  message: S.of(context).userAvatarSuccessMessage,
                  type: 0,
                );
              }
            },
            builder: (bccontext, state) {
              bool isUpdate = context.read<UserBloc>().isUpdate;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 30,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CustomAvatar(),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: AppColors.gray.withOpacity(0.1),
                              onTap:
                                  () => context
                                      .read<CloudinaryBloc>()
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
                      ],
                    ),
                    ProfileForm(
                      formKey: formKey,
                      usernameController: usernameController,
                      phoneController: phoneController,
                      emailAddressController: emailAddressController,
                      firstnameController: firstnameController,
                      lastnameController: lastnameController,
                      fullnameController: fullnameController,
                      usernameFocusNode: usernameFocusNode,
                      phoneFocusNode: phoneFocusNode,
                      firstnameFocusNode: firstnameFocusNode,
                      lastnameFocusNode: lastnameFocusNode,
                      fullnameFocusNode: fullnameFocusNode,
                      phoneTouched: phoneTouched,
                      usernameTouched: usernameTouched,
                      firstnameTouched: firstnameTouched,
                      lastnameTouched: lastnameTouched,
                      fullnameTouched: fullnameTouched,
                      screenWidth: screenWidth,
                    ),
                    ChangePinItem(screenContext: context),
                    EditProfileItem(
                      onSwitch: () {
                        if (isUpdate) {
                          context.read<UserBloc>().add(
                            UpdateUserEvent(
                              request: UpdateUserRequest(
                                firstname: firstnameController.text,
                                lastname: lastnameController.text,
                                fullname: fullnameController.text,
                                username: usernameController.text,
                                phoneNumber: phoneController.text,
                              ),
                            ),
                          );
                        } else {
                          context.read<UserBloc>().updateDetails(
                            isUpdate: true,
                          );
                        }
                      },
                    ),
                    if (!isInvestor) BecomeInvestorButton(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
