import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_partner_bar.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_partner_properties_list.dart';
import 'package:hessa/generated/l10n.dart';

class PartnerScreen extends StatelessWidget {
  final UserModel partner;

  const PartnerScreen({super.key, required this.partner});

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPartnerBar(partner: partner),
            Text(
              S.of(context).propertiesOfPartners,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CustomPartnerPropertiesList(
              partner: partner,
              screenContext: context,
            ),
          ],
        ),
      ),
    );
  }
}
