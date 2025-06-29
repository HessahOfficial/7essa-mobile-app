import 'package:flutter/material.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_range_slider.dart';
import 'package:hessa/generated/l10n.dart';

class CustomSliderList extends StatelessWidget {
  final double minAvailableShares;
  final double maxAvailableShares;
  final RangeValues availableSharesValues;
  final void Function(RangeValues) availableSharesOnchanged;

  final double minPrice;
  final double maxPrice;
  final RangeValues priceValues;
  final void Function(RangeValues) priceOnchanged;

  final double minPricePerShare;
  final double maxPricePerShare;
  final RangeValues pricePerShareValues;
  final void Function(RangeValues) pricePerShareOnchanged;

  final double minRentalIncome;
  final double maxRentalIncome;
  final RangeValues rentalIncomeValues;
  final void Function(RangeValues) rentalIncomeOnchanged;

  final double minArea;
  final double maxArea;
  final RangeValues areaValues;
  final void Function(RangeValues) areaOnchanged;

  final double minYearlyPayment;
  final double maxYearlyPayment;
  final RangeValues yearlyPaymentValues;
  final void Function(RangeValues) yealyPaymentOnchanged;

  const CustomSliderList({
    super.key,
    required this.minAvailableShares,
    required this.maxAvailableShares,
    required this.minPrice,
    required this.maxPrice,
    required this.minPricePerShare,
    required this.maxPricePerShare,
    required this.minRentalIncome,
    required this.maxRentalIncome,
    required this.minArea,
    required this.maxArea,
    required this.minYearlyPayment,
    required this.maxYearlyPayment,
    required this.availableSharesValues,
    required this.pricePerShareValues,
    required this.rentalIncomeValues,
    required this.areaValues,
    required this.yearlyPaymentValues,
    required this.availableSharesOnchanged,
    required this.priceOnchanged,
    required this.pricePerShareOnchanged,
    required this.rentalIncomeOnchanged,
    required this.areaOnchanged,
    required this.yealyPaymentOnchanged,
    required this.priceValues,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomRangeSlider(
          title: "${S.of(context).availableShares} (${S.of(context).unit}):",
          min: minAvailableShares,
          max: maxAvailableShares,
          values: availableSharesValues,
          onChanged: availableSharesOnchanged,
          isInt: true,
        ),
        CustomRangeSlider(
          title: "${S.of(context).price} (${S.of(context).egp}):",
          min: minPrice,
          max: maxPrice,
          values: priceValues,
          onChanged: priceOnchanged,
        ),
        CustomRangeSlider(
          title: "${S.of(context).pricePerShare} (${S.of(context).egp}):",
          min: minPricePerShare,
          max: maxPricePerShare,
          values: pricePerShareValues,
          onChanged: pricePerShareOnchanged,
        ),
        CustomRangeSlider(
          title: "${S.of(context).rentalIncome} (${S.of(context).egp}):",
          min: minRentalIncome,
          max: maxRentalIncome,
          values: rentalIncomeValues,
          onChanged: rentalIncomeOnchanged,
        ),
        CustomRangeSlider(
          title: "${S.of(context).area} (${S.of(context).squaredMeters}):",
          min: minArea,
          max: maxArea,
          values: areaValues,
          onChanged: areaOnchanged,
        ),
        CustomRangeSlider(
          title: "${S.of(context).paymentPerYear} (${S.of(context).egp}):",
          min: minYearlyPayment,
          max: maxYearlyPayment,
          values: yearlyPaymentValues,
          onChanged: yealyPaymentOnchanged,
        ),
      ],
    );
  }
}
