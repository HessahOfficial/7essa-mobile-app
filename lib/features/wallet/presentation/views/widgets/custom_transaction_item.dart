import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/features/wallet/data/models/transaction_model.dart';
import 'package:hessa/generated/l10n.dart';

class CustomTransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const CustomTransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  transaction.type == "Pay Shares" ||
                          transaction.type == "Fees" ||
                          transaction.type == "Withdrawal"
                      ? FontAwesomeIcons.arrowTrendDown
                      : FontAwesomeIcons.arrowTrendUp,
                  color: Colors.grey[600],
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.type == "Pay Shares"
                        ? S.of(context).payShares
                        : transaction.type == "Fees"
                        ? S.of(context).fees
                        : transaction.type == "Rent"
                        ? S.of(context).rent
                        : transaction.type == "Deposit"
                        ? S.of(context).depositFee
                        : transaction.type == "Withdrawal"
                        ? S.of(context).withdrawal
                        : S.of(context).bonus,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  if (transaction.propertyName != null)
                    Text(
                      transaction.propertyName!,
                      style: TextStyle(fontSize: 14, color: AppColors.gray),
                    ),
                  SizedBox(height: 4),
                  Text(
                    transaction.date,
                    style: TextStyle(fontSize: 14, color: AppColors.gray),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '${transaction.currency} ${transaction.amount}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
