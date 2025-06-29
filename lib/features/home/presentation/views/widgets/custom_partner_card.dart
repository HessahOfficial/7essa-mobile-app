import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';

class CustomPartnerCard extends StatelessWidget {
  final UserModel partner;

  const CustomPartnerCard({super.key, required this.partner});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: AppColors.gray.withOpacity(0.5),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            spacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(partner.avatar!),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 80,
                height: 80,
              ),
              Expanded(
                child: Text(
                  partner.fullName!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gray),
            ],
          ),
        ),
      ),
    );
  }
}
