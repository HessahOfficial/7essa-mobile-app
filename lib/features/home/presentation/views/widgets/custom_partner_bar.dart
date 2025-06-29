import 'package:flutter/material.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPartnerBar extends StatelessWidget {
  final UserModel partner;

  const CustomPartnerBar({super.key, required this.partner});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image(
            image: NetworkImage(partner.avatar!),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                partner.fullName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "${S.of(context).phoneNumber}: ${partner.phoneNumber!}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
