import 'package:flutter/material.dart';
import 'package:hessa/features/wallet/data/models/transaction_model.dart';
import 'package:hessa/features/wallet/presentation/views/widgets/custom_transaction_item.dart';

class CustomTransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  const CustomTransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder:
          (context, index) =>
              CustomTransactionItem(transaction: transactions[index]),
    );
  }
}
