import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';

import 'package:hessa/features/wallet/data/models/payment_model.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_badge.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPaymentItem extends StatelessWidget {
  final PaymentModel payment;

  const CustomPaymentItem({super.key, required this.payment});

  List<CustomBadge> getPaymentBadges(BuildContext context) {
    Map<String, Color> paymentStatusColors = {
      "pending": AppColors.developersColor,
      "paid": AppColors.newAddedColor,
      "declined": AppColors.bestForYouColor,
    };

    Map<String, Color> paymentMethodColors = {
      "instaPay": Color(0xFF7c569f),
      "VodafoneCash": Color(0xFFe60101),
      "bankTransfer": Color(0xFFFFFFFF),
    };

    Map<String, String> paymentStatusStrings = {
      "pending": S.of(context).pending,
      "paid": S.of(context).paid,
      "declined": S.of(context).declined,
    };

    Map<String, String> paymentMethodStrings = {
      "instaPay": S.of(context).instaPay,
      "VodafoneCash": S.of(context).vodafoneCash,
      "bankTransfer": S.of(context).bankTransfer,
    };

    List<CustomBadge> paymentBadges = [
      CustomBadge(
        text: paymentStatusStrings[payment.paymentStatus],
        color: paymentStatusColors[payment.paymentStatus],
      ),
      CustomBadge(
        text: paymentMethodStrings[payment.paymentMethod],
        color: paymentMethodColors[payment.paymentMethod],
      ),
    ];

    return paymentBadges;
  }

  String getFormattedDate() {
    String formattedDate = "";
    DateTime date = payment.paymentDate!;

    int day = date.day;
    int month = date.month;
    int year = date.year;

    int hour = date.hour;
    int minute = date.minute;
    int second = date.second;

    String amORPm = hour > 12 ? "PM" : "AM";
    String formattedHour = hour > 12 ? "${hour - 12}" : "$hour";
    String formattedMinute = minute < 10 ? "0$minute" : "$minute";
    String formattedSecond = second < 10 ? "0$second" : "$second";

    formattedDate +=
        "$formattedHour:$formattedMinute:$formattedSecond $amORPm | $year/$month/$day";

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.gray.withOpacity(0.5),
          ),
          child: Icon(
            FontAwesomeIcons.moneyBillTransfer,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 5,
                children: getPaymentBadges(context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.paymentType == "deposit"
                        ? S.of(context).deposit
                        : S.of(context).withdraw,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${payment.amount} EGP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      getFormattedDate(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
