import 'package:flutter/material.dart';
import 'package:hessa/features/investment/presentation/views/widgets/custom_invetment_item.dart';

class CustomInvestmentsList extends StatelessWidget {
  const CustomInvestmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 15,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => CustomInvetmentItem(),
    );
  }
}
