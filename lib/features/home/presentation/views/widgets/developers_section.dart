import 'package:flutter/material.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_developer_card.dart';

class DevelopersSection extends StatelessWidget {
  const DevelopersSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      padding: EdgeInsets.only(
        left: screenWidth * 0.06,
        right: screenWidth * 0.06,
        top: 10,
      ),
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return CustomDeveloperCard();
      },
    );
  }
}
