import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/home/data/models/get_all_partners_request.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_partner_card.dart';
import 'package:hessa/features/settings/presentation/managers/user_bloc.dart';

class PartenersSection extends StatefulWidget {
  const PartenersSection({super.key});

  @override
  State<PartenersSection> createState() => _PartenersSectionState();
}

class _PartenersSectionState extends State<PartenersSection> {
  @override
  void initState() {
    super.initState();

    context.read<UserBloc>().add(
      GetAllPartnersEvent(request: GetAllPartnersRequest()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (bccontext, state) {
        if (state is GetAllPartnersFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        }
      },
      builder: (bccontext, state) {
        List<UserModel> partners = context.read<UserBloc>().partnres;
        bool isDark = getIt.get<HiveHelper>().isDark ?? false;

        return state is GetAllPartnersSuccess
            ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: partners.length,
              itemBuilder: (context, index) {
                return CustomPartnerCard(partner: partners[index]);
              },
            )
            : Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                color:
                    isDark
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
              ),
            );
      },
    );
  }
}
