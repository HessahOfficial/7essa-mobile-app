import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/contact/data/models/contact_us_request.dart';
import 'package:hessa/features/contact/presentation/managers/contact_bloc.dart';
import 'package:hessa/features/contact/presentation/views/widgets/contact_us_form.dart';
import 'package:hessa/generated/l10n.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final messageController = TextEditingController();
  final subjectController = TextEditingController();
  final phoneController = TextEditingController();

  final messageFocusNode = FocusNode();
  final subjectFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  bool messageTouched = false;
  bool subjectTouched = false;
  bool phoneTouched = false;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    formKey = GlobalKey<FormState>();

    messageFocusNode.addListener(() {
      if (messageFocusNode.hasFocus) {
        setState(() {
          messageTouched = true;
        });
      }
    });
    subjectFocusNode.addListener(() {
      if (subjectFocusNode.hasFocus) {
        setState(() {
          subjectTouched = true;
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
  }

  @override
  void dispose() {
    messageController.dispose();
    subjectController.dispose();
    phoneController.dispose();

    messageFocusNode.dispose();
    subjectFocusNode.dispose();
    phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (bccontext, state) {
          if (state is RefreshTokenFailure) {
            showSnackBar(context: context, message: state.message, type: 1);
          }
        },
        builder: (bccontext, state) {
          final currentUser = getIt.get<HiveHelper>().currentUser;
          phoneController.text = currentUser!.phoneNumber ?? "";

          return BlocConsumer<ContactBloc, ContactState>(
            listener: (bccontext, state) {
              if (state is ContactUsFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              } else if (state is ContactUsSuccess) {
                showSnackBar(
                  context: context,
                  message: S.of(context).contactUsSuccess,
                  type: 0,
                );
              }
            },
            builder: (bccontext, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  leading: InkWell(
                    onTap: () => context.pop(),
                    splashColor: AppColors.gray.withOpacity(0.1),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                body: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.05),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      constraints: BoxConstraints(minHeight: screenHeight),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.06,
                          right: screenWidth * 0.06,
                          top: screenHeight * 0.02,
                        ),
                        child: Column(
                          spacing: 20,
                          children: [
                            Text(
                              S.of(context).contactUs,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              S.of(context).contactUsText,
                            ),
                            Icon(
                              FontAwesomeIcons.envelopesBulk,
                              size: 30,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            ContactUsForm(
                              formKey: formKey,
                              messageController: messageController,
                              messageFocusNode: messageFocusNode,
                              messageTouched: messageTouched,
                              phoneController: phoneController,
                              phoneFocusNode: phoneFocusNode,
                              phoneTouched: phoneTouched,
                              subjectController: subjectController,
                              subjectFocusNode: subjectFocusNode,
                              subjectTouched: subjectTouched,
                            ),
                            state is ContactUsLoading
                                ? CircularProgressIndicator(
                                  color: isDark ? Colors.white : Colors.black,
                                )
                                : CustomButton(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  width: 100,
                                  height: 50,
                                  text: S.of(context).sendButton,
                                  textColor: AppColors.backgroundColorLight,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<ContactBloc>().add(
                                        ContactUsEvent(
                                          request: ContactUsRequest(
                                            fullname: currentUser.fullName!,
                                            email: currentUser.email!,
                                            phoneNumber: phoneController.text,
                                            subject: subjectController.text,
                                            messageBody: messageController.text,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
