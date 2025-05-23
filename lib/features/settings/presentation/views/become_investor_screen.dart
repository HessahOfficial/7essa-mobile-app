import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";

import "package:hessa/core/helpers/hive_helper.dart";
import "package:hessa/core/themes/colors/app_colors.dart";
import "package:hessa/core/utils/service_locator.dart";
import "package:hessa/core/widgets/custom_button.dart";
import "package:hessa/features/settings/presentation/managers/investor_cubit.dart";
import "package:hessa/features/settings/presentation/views/widgets/investor_form.dart";
import "package:hessa/generated/l10n.dart";

class BecomeInvestorScreen extends StatelessWidget {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  BecomeInvestorScreen({super.key});

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
      body: BlocBuilder<InvestorCubit, InvestorState>(
        builder: (bccontext, state) {
          bool isInvestor = getIt.get<HiveHelper>().currentUser!.isInvestor ?? false;
          double screenWidth = MediaQuery.of(context).size.width;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              spacing: 20,
              children: [
                InvestorForm(
                  fullnameController: fullnameController,
                  nationalIdController: nationalIdController,
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
                CustomButton(
                  width: 100,
                  height: 50,
                  text: S.of(context).save,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<InvestorCubit>().becomeInvestor(
                        context: context,
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
