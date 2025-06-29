import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/investment/data/models/make_investment_request.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_counter_button.dart';
import 'package:hessa/generated/l10n.dart';

class CustomConfirmBottomSheet extends StatefulWidget {
  final PropertyModel property;

  const CustomConfirmBottomSheet({super.key, required this.property});

  @override
  State<CustomConfirmBottomSheet> createState() =>
      _CustomConfirmBottomSheetState();
}

class _CustomConfirmBottomSheetState extends State<CustomConfirmBottomSheet> {
  late int numberOfShares = 0;

  @override
  void initState() {
    super.initState();

    numberOfShares = 1;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: screenWidth * 0.06,
          ),
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.gray,
                    ),
                    width: 50,
                    height: 5,
                  ),
                ),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.property.title!,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${S.of(context).pricePerShare}: ${widget.property.pricePerShare} ${S.of(context).egpPerShare}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${S.of(context).availableShares}: ${widget.property.availableShares} ${S.of(context).shares}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${S.of(context).numberOfShares}: $numberOfShares ${S.of(context).shares}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${S.of(context).total}: ${numberOfShares * widget.property.pricePerShare!} ${S.of(context).egp}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: CustomCounterButton(
                                  value: numberOfShares,
                                  decrement: () {
                                    if (numberOfShares > 1) {
                                      setState(() {
                                        numberOfShares--;
                                      });
                                    }
                                  },
                                  increment: () {
                                    if (numberOfShares <
                                        widget.property.availableShares!) {
                                      setState(() {
                                        numberOfShares++;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      child: CustomButton(
                        onPressed: () {
                          context.read<InvestmentBloc>().add(
                            MakeInvestmentEvent(
                              request: MakeInvestmentRequest(
                                numberOfShares: numberOfShares,
                                propertyId: widget.property.id!,
                              ),
                            ),
                          );
                          context.pop();
                        },
                        width: 100,
                        height: 30,
                        text: S.of(context).confirm,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
