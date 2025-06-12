import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";

import "package:hessa/core/helpers/hive_helper.dart";
import "package:hessa/core/routes/app_routes.dart";
import "package:hessa/core/themes/colors/app_colors.dart";
import "package:hessa/core/utils/service_locator.dart";
import "package:hessa/core/utils/show_snack_bar.dart";
import "package:hessa/core/widgets/custom_button.dart";
import "package:hessa/features/settings/data/models/become_investor_request.dart";
import "package:hessa/features/settings/presentation/managers/user_bloc.dart";
import "package:hessa/features/settings/presentation/views/widgets/investor_form.dart";
import "package:hessa/generated/l10n.dart";

class BecomeInvestorScreen extends StatefulWidget {
  const BecomeInvestorScreen({super.key});

  @override
  State<BecomeInvestorScreen> createState() => _BecomeInvestorScreenState();
}

class _BecomeInvestorScreenState extends State<BecomeInvestorScreen> {
  final nationalIdController = TextEditingController();

  final nationalIdFocusNode = FocusNode();

  bool nationalIdTouched = false;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();

    nationalIdFocusNode.addListener(() {
      if (nationalIdFocusNode.hasFocus) {
        setState(() {
          nationalIdTouched = true;
        });
      }
    });
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
          S.of(context).becomeInvestor,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (bccontext, state) {
          if (state is BecomeInvestorFailure) {
            showSnackBar(context: context, message: state.message, type: 1);
          } else if (state is BecomeInvestorSuccess) {
            context.go(AppRoutes.ctaBecomInvestorView);
          }
        },
        builder: (bccontext, state) {
          double screenWidth = MediaQuery.of(context).size.width;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              spacing: 20,
              children: [
                InvestorForm(
                  nationalIdController: nationalIdController,
                  nationalIdFocusNode: nationalIdFocusNode,
                  nationalIdTouched: nationalIdTouched,
                  screenWidth: screenWidth,
                  formKey: formKey,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).becomInvestorNote,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                state is BecomeInvestorLoading
                    ? CircularProgressIndicator(
                      color: isDark ? Colors.white : Colors.black,
                    )
                    : CustomButton(
                      width: 100,
                      height: 50,
                      text: S.of(context).save,
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                            BecomeInvestorEvent(
                              request: BecomeInvestorRequest(
                                nationalId: nationalIdController.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
